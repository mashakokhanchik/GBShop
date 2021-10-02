//
//  ErrorViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 24.09.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showErrorMessage(message: String,
                          title: String? = "Ошибка",
                          handler: ((UIAlertAction) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: handler)
        alertViewController.addAction(okAlertAction)
        present(alertViewController, animated: true)
    }
    
}
