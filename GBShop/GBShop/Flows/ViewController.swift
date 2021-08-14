//
//  ViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 03.08.2021.
//

import UIKit

class ViewController: UIViewController {

    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login()
    }
    
    func login() {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.login(userName: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    func singin() {}
//    func changeUserData() {}
//    func logout(){}

}

