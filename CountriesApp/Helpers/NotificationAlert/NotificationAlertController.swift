
//MARK: REUSED FROM SELF CREATED CODE

import UIKit

class NotificationAlertController: UIViewController {
    
    static var edgesInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    static var numberOfLines: Int = 7 {
        didSet {
            NotificationAlertController.shared.titleLabel?.numberOfLines = numberOfLines
        }
    }
    static var font: UIFont = .systemFont(ofSize: 15, weight: .heavy) {
        didSet {
            NotificationAlertController.shared.titleLabel?.font = font
        }
    }
    static var backgroundColor: UIColor = #colorLiteral(red: 0.1776832044, green: 0.9827167392, blue: 0.6427057385, alpha: 1) {
        didSet {
            NotificationAlertController.shared.backrgoundView.backgroundColor = backgroundColor
        }
    }
    static var presentationInterval: TimeInterval = 3.5
    static var animationDuration: TimeInterval = 0.45
    static var animationDelay: TimeInterval = 0
    static var dampingRatio:CGFloat = 1
    
    fileprivate static var shared = NotificationAlertController()
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backrgoundView: UIView!
    
    private var titleMessage: String? {
        didSet {
            titleLabel?.text = titleMessage
        }
    }
    
    private var layoutConstraints: [NSLayoutConstraint] = []
    private var presentingLayoutContraint: NSLayoutConstraint?
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animatePresenting()
        setupAutoHiding()
    }
    
    func setup() {
        view.translatesAutoresizingMaskIntoConstraints = false
        backrgoundView.backgroundColor = NotificationAlertController.backgroundColor
        titleLabel.text = titleMessage
        titleLabel.numberOfLines = NotificationAlertController.numberOfLines
        
        let removeGesture = UISwipeGestureRecognizer(target: self, action: #selector(gestureFired(_:)))
        removeGesture.direction = .up
        view.addGestureRecognizer(removeGesture)
    }
    
    func add(in parentVC: UIViewController) {
        parentVC.addChild(self)
        parentVC.view.addSubview(view)
        didMove(toParent: parentVC)
        
        let left = view.leftAnchor.constraint(equalTo: parentVC.view.leftAnchor, constant: NotificationAlertController.edgesInset.left)
        left.isActive = true
        layoutConstraints.append(left)
        
        let right = view.rightAnchor.constraint(equalTo: parentVC.view.rightAnchor, constant: NotificationAlertController.edgesInset.right)
        right.isActive = true
        layoutConstraints.append(right)
        
        presentingLayoutContraint = view.topAnchor.constraint(equalTo: parentVC.view.topAnchor, constant: NotificationAlertController.edgesInset.top)
        presentingLayoutContraint?.isActive = false
        
        let bottom = view.bottomAnchor.constraint(equalTo: parentVC.view.topAnchor)
        bottom.priority = .init(750)
        bottom.isActive = true
        layoutConstraints.append(bottom)
        
        view.superview?.layoutIfNeeded()
    }
    
    func removeFromParentVC() {
        removeTimer()
        
        NSLayoutConstraint.deactivate(layoutConstraints)
        presentingLayoutContraint?.isActive = false
        presentingLayoutContraint = nil
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func animatePresenting(comletion handler: (()->())? = nil) {
        view.superview?.layoutIfNeeded()
        presentingLayoutContraint?.isActive = true
        
        animate(block: {
            self.view.superview?.layoutIfNeeded()
        }) {
            handler?()
        }
    }
    
    func animateDismissing(comletion handler: (()->())? = nil) {
        view.superview?.layoutIfNeeded()
        presentingLayoutContraint?.isActive = false
        animate(block: {
            self.view.superview?.layoutIfNeeded()
        }) {
            handler?()
        }
    }
    
    func animate(block: @escaping ()->(), completion handler: (()->())? = nil) {
        UIView.animate(withDuration: NotificationAlertController.animationDuration,
                       delay: NotificationAlertController.animationDelay,
                       usingSpringWithDamping: NotificationAlertController.dampingRatio,
                       initialSpringVelocity: 0,
                       options: .curveEaseIn,
                       animations: { block() }) { (_) in handler?() }
    }
    
    func setupAutoHiding() {
        timer = Timer.scheduledTimer(withTimeInterval: NotificationAlertController.presentationInterval,
                                          repeats: false,
                                          block: { [weak self] (_) in
                                            self?.animateDismissing(comletion: {
                                                self?.removeFromParentVC()
                                            })
        })
    }
    
    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func gestureFired(_ gesture: UISwipeGestureRecognizer) {
        guard gesture.direction == .up else {
            return
        }
        
        removeTimer()
        animateDismissing {
            self.removeFromParentVC()
        }
    }
}

extension NotificationAlertController {
    
    public static func present(with title: String, in vc: UIViewController? = nil) {
        guard let presentingVC = vc ?? (UIApplication.shared.keyWindow?.topController) else {
            return
        }
        
        let alert = NotificationAlertController.shared
        alert.titleMessage = title
        
        alert.removeFromParentVC()
        
        alert.add(in: presentingVC)
    }
    
    public static func handle(error: CAError, in vc: UIViewController? = nil) {
        NotificationAlertController.present(with: error.description)
    }
}

