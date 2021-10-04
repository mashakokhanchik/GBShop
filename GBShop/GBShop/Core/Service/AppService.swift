//
//  AppService.swift
//  GBShop
//
//  Created by Мария Коханчик on 25.09.2021.
//

import UIKit

class AppService {
    
    // MARK: - Properties
    
    static var shared = AppService()
    let session = AppSession()
    var window: UIWindow?
    var rootViewController: UIViewController?
    
    // MARK: - Methods
    
    func start(_ window: UIWindow? = nil) {
        if let window = window {
            self.window = window
            configure()
        }
        return
    }
    
    func getScreenPage(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier)
    }
    
    // MARK: - Private methods
    
    private func configure() {
        let catalog = getScreenPage(identifier: "catalogScreen")
        let prifile = getScreenPage(identifier: "profileScreen")
        
        let tabBarBuilder = TabBarBuilder()
        
        tabBarBuilder.addNavigationController(viewController: catalog,
                                              title: "Каталог",
                                              image: "folder",
                                              selectedImage: "folder.fill")
        tabBarBuilder.addNavigationController(viewController: prifile,
                                              title: "Профиль",
                                              image: "person",
                                              selectedImage: "person.fill")
        
        let tabBar = tabBarBuilder.build()
        self.rootViewController = tabBar
        
        window?.rootViewController = self.rootViewController
        window?.makeKeyAndVisible()
    }

}
