//
//  BaseViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 24.09.2021.
//

import UIKit

// MARK: - Login Delegate implementation

protocol NeedLoginDelegate: AnyObject {
    
    func willReloadData()
    func willDisappear(bool: Bool)

}

protocol FillLoginScreenDelegate: AnyObject {
    
    func fillLoginScreenWith(userName: String?, password: String?)

}

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var appService = AppService.shared
    var userId: Int? { return AppService.shared.session.userInfo?.id }
    var userName: String? { return AppService.shared.session.userInfo?.login }
    var isNeedLogin: Bool { return userId == nil }
    var userNameLogin: String?
    var passwordLogin: String?
    var productId: Int? { return AppService.shared.session.productInfo?.productId }
    
    weak var needLoginDelegate: NeedLoginDelegate?
    weak var fillLoginScreenDelegate: FillLoginScreenDelegate?
    
    // MARK: - Public methods
    
    public func login(delegate: NeedLoginDelegate?) {
        if userId == nil {
            if let needLogin = AppService.shared.getScreenPage(identifier: "loginScreen") as? BaseViewController {
                needLogin.needLoginDelegate = delegate
                needLogin.modalPresentationStyle = .overFullScreen
                present(needLogin, animated: true)
            }
        } else {
            showErrorMessage(message: "Вы уже авторизованы")
        }
    }

}
