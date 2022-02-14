//
//  TabBarBuilder.swift
//  GBShop
//
//  Created by Мария Коханчик on 25.09.2021.
//

import UIKit

final class TabBarBuilder {
    
    private var tabs = [UIViewController]()
    
    public func addNavigationController(viewController: UIViewController,
                                        title: String?,
                                        image: String?,
                                        selectedImage: String?) {
        let tabBarNavigationController = UINavigationController()
        let tabBarNavigationControllerIcon = UITabBarItem(title: title,
                                                          image: (image != nil ? UIImage(systemName: image!) : nil),
                                                          selectedImage: (selectedImage != nil ? UIImage(systemName: selectedImage!) : nil))
        
        tabBarNavigationController.tabBarItem = tabBarNavigationControllerIcon
        tabBarNavigationController.viewControllers = [viewController]
        tabs.append(tabBarNavigationController)
    }
    
    public func getActiveControllerFrom(controller: UITabBarController) -> UIViewController? {
        let selectIndex = controller.selectedIndex
        
        if let viewControllers = controller.viewControllers,
           viewControllers.count <= selectIndex {
            return viewControllers[selectIndex]
        }
        
        return nil
    }
    
    public func build() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = tabs
        
        return tabBarController
    }

}
