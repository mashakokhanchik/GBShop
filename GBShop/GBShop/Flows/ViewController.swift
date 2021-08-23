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
        registration()
        changeUserData()
        logout()
        getCatalogData()
        getGoodsById()
    }

//MARK: - Authentication functions
    
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
    
    func registration() {
        let registration = requestFactory.makeAuthRequestFactory()
        registration.registration(userName: "Somebody", password: "mypassword", email: "some@some.ru") { response in
            switch response.result {
            case .success(let registration):
                print(registration)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func changeUserData() {
        let changeUserData = requestFactory.makeAuthRequestFactory()
        changeUserData.changeUserData(userName: "Somebody", passord: "mypassword", email: "some@some.ru") { response in
            switch response.result {
            case .success(let changeUserData):
                print(changeUserData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func logout() {
        let auth = requestFactory.makeAuthRequestFactory()
        auth.logout(userId: "123") { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//MARK: - Сatalog functions
    
    func getCatalogData() {
        let getCatalogData = requestFactory.makeCatalogDataRequestFactory()
        getCatalogData.getCatalogData(pageNumber: "1", idCategory: "1") { response in
            switch response.result {
            case .success(let getCatalogData):
                print(getCatalogData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//MARK: - GoodsById functions
    
    func getGoodsById() {
        let getGoodsById = requestFactory.makeGoodsByIdFactory()
        getGoodsById.getGoodsById(id: "123") { response in
            switch response.result {
            case .success(let getGoodsById):
                print(getGoodsById)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

