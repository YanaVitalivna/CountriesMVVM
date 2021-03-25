
//MARK: REUSED FROM SELF CREATED CODE

import UIKit

public protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    public static var identifier: String {
        return String(describing: self)
    }
}

extension UIView: Reusable {}

extension UIView {
    /// Used to load UIView designed in Xib file,
    /// - Use example: `var view: CustomNibView = .fromNib()`
    /// - Returns: object of loaded from Xib view, in case if Xib could not be found calls fatal Error
    public static func fromNib<T>(_ type: T.Type = T.self) -> T where T: AnyObject {
        
        let bundle = Bundle.init(for: T.self)
        
        guard let view = bundle.loadNibNamed(self.identifier, owner: nil, options: nil)?.first as? T
            else { fatalError("XIB Loading error, check the name of xib file, it should me exactly the same as class name")}
        
        return view
    }
}

extension UITableView {
    
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        let bundle = Bundle(for: cellClass.self)
        
        if bundle.path(forResource: cellClass.identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: cellClass.identifier, bundle: bundle)
            register(nib, forCellReuseIdentifier: cellClass.identifier)
        }
        else {
            register(cellClass.self, forCellReuseIdentifier: cellClass.identifier)
            
        }
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type = T.self, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as! T
    }
    
    public func register<T: UITableViewHeaderFooterView>(sectionViewClass: T.Type) {
        let bundle = Bundle(for: sectionViewClass.self)
        
        if bundle.path(forResource: sectionViewClass.identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: sectionViewClass.identifier, bundle: bundle)
            register(nib, forHeaderFooterViewReuseIdentifier: sectionViewClass.identifier)
        }
        else {
            register(sectionViewClass.self, forHeaderFooterViewReuseIdentifier: sectionViewClass.identifier)
        }
    }
    
    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(sectionViewClass: T.Type = T.self) -> T {
        dequeueReusableHeaderFooterView(withIdentifier: sectionViewClass.identifier) as! T
    }
}

extension UICollectionView {
    public func register<T: UICollectionViewCell>(cellClass: T.Type) {
        let bundle = Bundle(for: cellClass.self)
        
        if bundle.path(forResource: cellClass.identifier, ofType: "nib") != nil {
            let nib = UINib(nibName: cellClass.identifier, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: cellClass.identifier)
        }
        else {
            register(cellClass.self, forCellWithReuseIdentifier: cellClass.identifier)
        }
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: cellClass.identifier, for: indexPath) as! T
    }
}

