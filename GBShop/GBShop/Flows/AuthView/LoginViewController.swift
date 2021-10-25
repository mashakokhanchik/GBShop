//
//  LoginViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 24.09.2021.
//

import UIKit
import Firebase

class LoginViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var authScrollView: UIScrollView!
    
    // MARK: - Properties
    
    let userFactory = RequestFactory().makeAuthRequestFactory()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewClicked(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    // MARK: - Methods
    
    @objc func viewClicked(_ sender: UIView) {
        view.endEditing(true)
        scrollViewReset()
    }
    
    @objc func keyboardWasShow(notification: Notification) {
        guard let notificationInfo = notification.userInfo as NSDictionary?,
              let keyboarSizeInfo = notificationInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue
        else { return }
        
        let keyboardSize = keyboarSizeInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        authScrollView.contentInset = contentInsets
        authScrollView.scrollIndicatorInsets = contentInsets
        authScrollView.contentOffset = CGPoint(x: 0, y: keyboardSize.height)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        scrollViewReset()
    }
    
    fileprivate func scrollViewReset() {
        authScrollView.contentInset = UIEdgeInsets.zero
        authScrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        authScrollView.contentOffset = CGPoint.zero
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        /// Firebase Analytics

//        Analytics.logEvent(AnalitycsEventSelectContent, parameters: [
//            AnalyticsParameterItemID: "id-\(title!)",
//            AnalyticsParameterItemName: title!,
//            AnalyticsParameterContentType: "cont"])
        
        guard let userName = userNameTextField.text,
              let password = passwordTextField.text,
              !userName.isEmpty,
              !password.isEmpty
        else { self.showErrorMessage(message: "Необходимо ввести имя пользователя и пароль")
            return
        }
        userFactory.login(userName: userName, password: password) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let login):
                DispatchQueue.main.async {
                    self.appService.session.setUserInfo(login.user)
                    self.needLoginDelegate?.willReloadData()
                    self.needLoginDelegate?.willDisappear(bool: false)
                    self.dismiss(animated: true)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showErrorMessage(message: "При попытке входа произошла ошибка")
                }
            }
        }
    }
    
    @IBAction func registrationButtonPressed(_ sender: Any) {
        
        /// Firebase Crashlytics

//        // Set int_key to 100.
//        Crashlytics.crashlytics().setCustomValue(100, forKey: "int_key")
//
//        // Set str_key to "hello".
//        Crashlytics.crashlytics().setCustomValue("hello", forKey: "str_key")
//
//        let keysAndValues = [
//                         "string key" : "string value",
//                         "string key 2" : "string value 2",
//                         "boolean key" : true,
//                         "boolean key 2" : false,
//                         "float key" : 1.01,
//                         "float key 2" : 2.02
//                        ] as [String : Any]
//
//        Crashlytics.crashlytics().setCustomKeysAndValues(keysAndValues)
//        Crashlytics.crashlytics().log("Test registration crash")
//        Crashlytics.crashlytics().setUserID("123456789")
//
//        let numbers = [0]
//        let _ = numbers[1]
        
        
        guard let registrationViewController = AppService.shared.getScreenPage(identifier: "registrationScreen") as? RegistrationViewController
        else { return }
        registrationViewController.fillLoginScreenDelegate = self
        userNameTextField.text = nil
        passwordTextField.text = nil
        registrationViewController.modalPresentationStyle = .overFullScreen
        present(registrationViewController, animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
        self.needLoginDelegate?.willDisappear(bool: true)
    }
    
}

extension LoginViewController: FillLoginScreenDelegate {
    
    func fillLoginScreenWith(userName: String?, password: String?) {
        userNameTextField.text = userName
        passwordTextField.text = password
    
    }

}
