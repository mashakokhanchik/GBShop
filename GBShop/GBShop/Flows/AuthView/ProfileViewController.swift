//
//  ProfileViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 25.09.2021.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatNewPasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet var userDataProfileLabels: [UILabel]!
    @IBOutlet var userDataPrifileTextField: [UITextField]!
    
    @IBOutlet weak var isNeedLoginLabel: UILabel!
    @IBOutlet weak var isNeedLoginButton: UIButton!
    
    // MARK: - Properties
    
    var userFactory = RequestFactory().makeAuthRequestFactory()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProfileInterface()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if !isNeedLogin {
            loadProfile()
        } else {
            login(delegate: self)
            isNeedLoginLabel.text = "Необходима авторизация"
            isNeedLoginButton.setTitle("Войти", for: .normal)
        }
    }
    
    // MARK: - Private methods
    
    private func loadProfile() {
        if let userId = userId {
            userFactory.getUserData(userId: userId) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(userData):
                    DispatchQueue.main.async {
                        self.willDisappear(bool: false)
                        self.userNameTextField.text = userData.login
                        self.oldPasswordTextField.text = userData.password
                        self.emailTextField.text = userData.email
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.willDisappear(bool: true)
                        self.showErrorMessage(message: "Невозможно загрузить данные")
                        self.isNeedLoginLabel.text = "Невозможно загрузить данные"
                        self.isNeedLoginButton.setTitle("Выйти", for: .normal)
                    }
                }
            }
        } else {
            willDisappear(bool: true)
            showErrorMessage(message: "Невозможно загрузит данные")
            isNeedLoginLabel.text = "Невозможно загрузить данные"
            isNeedLoginButton.setTitle("Выйти", for: .normal)
        }
    }
    
    private func showProfileInterface(hide: Bool = true) {
        if !isNeedLogin {
            willDisappear(bool: false)
        } else {
            willDisappear(bool: true)
        }
    }
    
    private func toggleProfileInterface(hide: Bool = true) {
        for usedDataLabels in userDataProfileLabels {
            usedDataLabels.isHidden = hide
        }
        for userDataTextField in userDataPrifileTextField {
            userDataTextField.isHidden = hide
        }
        saveButton.isHidden = hide
        logoutButton.isHidden = hide
        isNeedLoginLabel.isHidden = !hide
        isNeedLoginButton.isHidden = !hide
    }
    
    // MARK: - Methods
    
    @objc private func viewClicked() {
        view.endEditing(true)
    }
    
    func logout() {
        if let userId = userId {
            userFactory.logout(userId: userId) { [ weak self] response in
                guard let self = self else { return }
                
                switch response.result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.showLogoutMessage(message: "Вы уыеренны, что хотите выйти?")
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showErrorMessage(message: "При попытке выхода произошла ошибка")
                    }
                }
            }
        } else {
            showErrorMessage(message: "При попытке выхода произошла ошибка")
        }
        isNeedLoginLabel.text = "Необходима авторизация"
        isNeedLoginButton.setTitle("Войти", for: .normal)
    }
    
    func showLogoutMessage(message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Выйти", style: .default) { _ in
            self.appService.session.killUserInfo()
            self.showProfileInterface()
        }
        let noAction = UIAlertAction(title: "Отмена", style: .default, handler: handler)
        alertViewController.addAction(okAction)
        alertViewController.addAction(noAction)
        present(alertViewController, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func isNeedLoginButtonPressed(_ sender: Any) {
        if !isNeedLogin {
            logout()
        } else {
            login(delegate: self)
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            return showErrorMessage(message: "Введите имя пользователя")
        }
        guard let password = oldPasswordTextField.text, !password.isEmpty else {
            return showErrorMessage(message: "Введите пароль, чтобы внести изменения")
        }
        let newPassword = newPasswordTextField.text
        let repeatNewPassword = repeatNewPasswordTextField.text
        guard newPassword == repeatNewPassword else {
            return showErrorMessage(message: "Пароли должны совпадать")
        }
        guard password != newPassword else {
            return showErrorMessage(message: "Новый пароль должен отличаться от старого")
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            return showErrorMessage(message: "Введите email")
        }
        /// Проверка на корректность email
        let splitedWithSymbolAt = email.split(separator: "@", maxSplits: 1)
        let beforeSymbolAt = String(splitedWithSymbolAt.first ?? " ")
        let afterSymbolAt = String(splitedWithSymbolAt.last ?? " ")
        let splitedWithSymbolDot = afterSymbolAt.split(separator: ".", maxSplits: 1)
        let beforeSymbolDot = String(splitedWithSymbolDot.first ?? " ")
        let afterSymbolDot = String(splitedWithSymbolDot.last ?? " ")
        
        guard splitedWithSymbolAt.count == 2,
              splitedWithSymbolDot.count == 2,
              beforeSymbolAt.count >= 1,
              beforeSymbolDot.count >= 1,
              afterSymbolDot.count >= 2 else {
            return showErrorMessage(message: "Введён некорректный email")
        }
        guard let userId = userId else { return }
        
        let user = User(id: userId,
                        login: userName,
                        lastname: nil,
                        email: email,
                        password: password,
                        newPassword: newPassword)
        userFactory.changeUserData(userName: user) { [weak self] response in
            guard let self = self else { return }
            
            switch response.result {
            case let .success(changeUserData):
                DispatchQueue.main.async {
                    switch  changeUserData {
                    case (_) where changeUserData.result == 1:
                        self.showErrorMessage(message: "Данные успешно изменены")
                    case (_) where changeUserData.result == 0:
                        self.showErrorMessage(message: "Ошибка")
                    default:
                        self.showErrorMessage(message: "Ошибка")
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showErrorMessage(message: "Ошибка")
                }
            }
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        logout()
    }
    
}

extension ProfileViewController: NeedLoginDelegate {
    
    func willReloadData() {
        loadProfile()
    }
    
    func willDisappear(bool: Bool) {
        toggleProfileInterface()
    }
    
}
