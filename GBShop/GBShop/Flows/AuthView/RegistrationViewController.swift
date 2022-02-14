//
//  RegistrationViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 25.09.2021.
//

import UIKit

class RegistrationViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeadPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - Properties
    
    let userFactory = RequestFactory().makeAuthRequestFactory()
    var userLogin: String?
    var userPassword: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Реистрация"
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Methods
    
    @objc private func viewClicked() {
        view.endEditing(true)
    }
    
    // MARK: - Actions

    @IBAction func registrationButtonPressed(_ sender: Any) {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            return showErrorMessage(message: "Введите имя", title: "Ошибка")
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            return showErrorMessage(message: "Введите пароль", title: "Ошибка")
        }
        guard let repeadPassword = repeadPasswordTextField.text, !repeadPassword.isEmpty else {
            return showErrorMessage(message: "Повторите пароль", title: "Ошибка")
        }
        guard password == repeadPassword else {
            return showErrorMessage(message: "Пароли должны совпадать", title: "Ошибка")
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            return showErrorMessage(message: "Введите email", title: "Ошибка")
        }
        guard isCorrectEmail(email) else {
            return showErrorMessage(message: "Введён некорректный email", title: "Ошибка")
        }
        let newUser = User(id: nil,
                           login: userName,
                           lastname: nil,
                           email: email,
                           password: password,
                           newPassword: nil)
        userFactory.registration(userName: newUser) { response in
    
            switch response.result {
            
            case let .success(registrationResult):
                DispatchQueue.main.async {
                    switch registrationResult {
                    case (_ ) where registrationResult.result == 1:
                        self.fillLoginScreenDelegate?.fillLoginScreenWith(userName: self.userNameTextField.text,
                                                                          password: self.passwordTextField.text)
                        self.showErrorMessage(message: registrationResult.userMessage,
                                              title: "Успешно") { [ weak self] _ in
                            guard let self = self else { return }
                            self.dismiss(animated: true)
                        }
                    default:
                        self.showErrorMessage(message: registrationResult.userMessage, title: "Ошибка")
                }
            }
            case .failure(_):
                self.showErrorMessage(message: "Ошибка регистрации")
            }
        }
    }
    
    func isCorrectEmail(_ email: String) -> Bool {
        let emailRegistrationExist = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegistrationExist)
        return emailPredicate.evaluate(with: email)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
        self.needLoginDelegate?.willDisappear(bool: true)
    }

}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }

}
