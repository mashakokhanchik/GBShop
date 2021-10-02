//
//  ViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 03.08.2021.
//

<<<<<<< HEAD
import UIKit

class ViewController: UIViewController {

    let requestFactory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login()//Вход пользователя
        registration()//Регистрация пользователя
        changeUserData()//Изменение личных данных пользователя
        logout()//Выход пользователя
        getCatalogData()//Получение списка товаров
        getGoodsById()//Получение отдельного товара
        getReview()//Получение списка отзывов о товаре
        addReview()//Добавление отзыва о товаре
        removeReview()//Удаление отзыва о товаре
<<<<<<< HEAD
        addToBasket()//Добавление товара в корзину
        deleteFromBasket()//Удаление товара из корзины
        payBasket()//Списание денежных средств
=======
>>>>>>> refs/remotes/origin/develop
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
            case .success(let logout):
                print(logout)
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
        getGoodsById.getGoodsById(idProduct: "123") { response in
            switch response.result {
            case .success(let getGoodsById):
                print(getGoodsById)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//MARK: - Reviews functions
    
    func getReview() {
        let getReview = requestFactory.makeReviewsFactory()
        getReview.getReview(pageNumber: "1") { response in
            switch response.result {
            case .success(let getReview):
                print(getReview)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addReview() {
        let addReview = requestFactory.makeReviewsFactory()
        addReview.addReview(userId: 1, userReview: "SomeReview") { response in
            switch response.result {
            case .success(let addReview):
                print(addReview)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeReview() {
        let removeReview = requestFactory.makeReviewsFactory()
        removeReview.removeReview(idReview: 1, removeMessage: "SomeMessage") { response in
            switch response.result {
            case .success(let removeReview):
                print(removeReview)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
<<<<<<< HEAD
    
// MARK: - Basket functions
    
    func addToBasket() {
        let addToBasket = requestFactory.makeBasketFactory()
        addToBasket.addToBasket(idProduct: 1, quantity: 1) { response in
            switch response.result {
            case .success(let addToBasket):
                print(addToBasket)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteFromBasket() {
        let deleteFromBasket = requestFactory.makeBasketFactory()
        deleteFromBasket.deleteFromBasket(idProduct: 1) { response in
            switch response.result {
            case .success(let deleteFromBasket):
                print(deleteFromBasket)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func payBasket() {
        let payBasket = requestFactory.makeBasketFactory()
        payBasket.payBasket(userId: 1, userMessage: "SomeMessage") { response in
            switch response.result {
            case .success(let payBasket):
                print(payBasket)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
=======
>>>>>>> refs/remotes/origin/develop

}
=======
//import UIKit
//
//class ViewController: UIViewController {
//
//    let requestFactory = RequestFactory()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        login()//Вход пользователя
//        registration()//Регистрация пользователя
//        changeUserData()//Изменение личных данных пользователя
//        logout()//Выход пользователя
//        getCatalogData()//Получение списка товаров
//        getGoodsById()//Получение отдельного товара
//        getReview()//Получение списка отзывов о товаре
//        addReview()//Добавление отзыва о товаре
//        removeReview()//Удаление отзыва о товаре
//        addToBasket()//Добавление товара в корзину
//        deleteFromBasket()//Удаление товара из корзины
//        payBasket()//Списание денежных средств
//    }
//
//    // MARK: - Authentication functions
//    
//    func login() {
//        let auth = requestFactory.makeAuthRequestFactory()
//        auth.login(userName: "Somebody", password: "mypassword") { response in
//            switch response.result {
//            case .success(let login):
//                print(login)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func registration() {
//        let registration = requestFactory.makeAuthRequestFactory()
//        registration.registration(userName: "Somebody", password: "mypassword", email: "some@some.ru") { response in
//            switch response.result {
//            case .success(let registration):
//                print(registration)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func changeUserData() {
//        let changeUserData = requestFactory.makeAuthRequestFactory()
//        changeUserData.changeUserData(userName: "Somebody", passord: "mypassword", email: "some@some.ru") { response in
//            switch response.result {
//            case .success(let changeUserData):
//                print(changeUserData)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func logout() {
//        let auth = requestFactory.makeAuthRequestFactory()
//        auth.logout(userId: 1) { response in
//            switch response.result {
//            case .success(let logout):
//                print(logout)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    // MARK: - Сatalog functions
//    
//    func getCatalogData() {
//        let getCatalogData = requestFactory.makeCatalogDataRequestFactory()
//        getCatalogData.getCatalogData(pageNumber: "1", idCategory: "1") { response in
//            switch response.result {
//            case .success(let getCatalogData):
//                print(getCatalogData)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    // MARK: - GoodsById functions
//    
//    func getGoodsById() {
//        let getGoodsById = requestFactory.makeGoodsByIdFactory()
//        getGoodsById.getGoodsById(idProduct: "123") { response in
//            switch response.result {
//            case .success(let getGoodsById):
//                print(getGoodsById)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    // MARK: - Reviews functions
//    
//    func getReview() {
//        let getReview = requestFactory.makeReviewsFactory()
//        getReview.getReview(pageNumber: "1") { response in
//            switch response.result {
//            case .success(let getReview):
//                print(getReview)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func addReview() {
//        let addReview = requestFactory.makeReviewsFactory()
//        addReview.addReview(userId: 1, userReview: "SomeReview") { response in
//            switch response.result {
//            case .success(let addReview):
//                print(addReview)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func removeReview() {
//        let removeReview = requestFactory.makeReviewsFactory()
//        removeReview.removeReview(idReview: 1, removeMessage: "SomeMessage") { response in
//            switch response.result {
//            case .success(let removeReview):
//                print(removeReview)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    // MARK: - Basket functions
//    
//    func addToBasket() {
//        let addToBasket = requestFactory.makeBasketFactory()
//        addToBasket.addToBasket(idProduct: 1, quantity: 1) { response in
//            switch response.result {
//            case .success(let addToBasket):
//                print(addToBasket)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func deleteFromBasket() {
//        let deleteFromBasket = requestFactory.makeBasketFactory()
//        deleteFromBasket.deleteFromBasket(idProduct: 1) { response in
//            switch response.result {
//            case .success(let deleteFromBasket):
//                print(deleteFromBasket)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func payBasket() {
//        let payBasket = requestFactory.makeBasketFactory()
//        payBasket.payBasket(userId: 1, userMessage: "SomeMessage") { response in
//            switch response.result {
//            case .success(let payBasket):
//                print(payBasket)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//
//}
>>>>>>> feature/hw7

