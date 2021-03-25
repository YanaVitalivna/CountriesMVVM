
//MARK: REUSED FROM SELF CREATED CODE

import Foundation
import Alamofire

typealias SuccessResponse<T> = ((T) -> ())
typealias FailureResponse = ((CAError) -> ())
typealias Method = HTTPMethod

struct Empty: Codable {}

class BaseRequest<T: Decodable> {
    let method: HTTPMethod
    let url: URL
    var headers: [String: String]?
    var params: [String: Any]?
    let encoding: ParameterEncoding
    let showLog: Bool
    
    private var successCallback: SuccessResponse<T>?
    private var failureCallback: FailureResponse?
    
    private var request: DataRequest?
    
    init(method:            Method,
         url:               URL,
         headers:           [String: String]? = nil,
         params:            [String: Any]? = nil,
         encoding:          ParameterEncoding = JSONEncoding.default,
         showLog:           Bool = false) {
        
        self.method             = method
        self.url                = url
        self.headers            = headers
        self.params             = params
        self.encoding           = encoding
        self.showLog            = showLog
    }
    
    func execute() {
        
        request = Alamofire.SessionManager.default.request(url, method: method, parameters: params, encoding: encoding, headers: headers).responseData(completionHandler: { (response) in
            
            switch response.result {
                
            case .success(let data):
                self.onSuccess(data, code: response.response?.statusCode)
                
            case .failure(let error):
                self.onFailure(error, code: response.response?.statusCode)
                
            }
        })
    }
    
    func cancel() {
        request?.cancel()
    }
    
    func success(_ handler: @escaping SuccessResponse<T>) -> BaseRequest<T> {
        successCallback = handler
        return self
    }
    
    func failure(_ handler: @escaping FailureResponse) -> BaseRequest<T> {
        failureCallback = handler
        return self
    }
    
    
    func onSuccess(_ data: Data, code: Int?) {
        log(code: code, object: data, isError: false)
        
        do {
            let response = try parseResponse(data)
            
            successCallback?(response)
        }
        catch {
            log(code: code, object: error, isError: true)
            failureCallback?(.responseParseError(error.localizedDescription))
        }
    }
    
    
    func onFailure(_ error: Error, code: Int?) {
        log(code: code, object: error, isError: true)
        
        failureCallback?(.responseError(error.localizedDescription))
    }
    
    
    func parseResponse(_ data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
    
    private func log(code: Int?, object: Any, isError: Bool) {
        if showLog {
            print("Code: ", code ?? 0)
            
            print(isError  ? "Error ☠️:" : "Success 🐥: ")
            
            if let data = object as? Data {
                print(String.init(data: data, encoding: .utf8) ?? "Nan")
            }
            else {
                print(object)
            }
            
        }
    }
}
