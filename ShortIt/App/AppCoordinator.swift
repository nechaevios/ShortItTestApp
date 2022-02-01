//
//  AppCoordinator.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 31.01.2022.
//

import UIKit

protocol TabCoordinator: AnyObject {
    var rootController: UIViewController { get }
    var tabBarItem: UITabBarItem { get }
}

class AppCoordinator {
    
    var tabBarController: UITabBarController
    var tabs: [TabCoordinator] = []

    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.tabBarController = UITabBarController()
        self.window = window
        
        window?.rootViewController = tabBarController
        
        guard let mainTab = MainTabCoordinator() as TabCoordinator? else { return }
        guard let historyTab = HistoryTabCoordinator() as TabCoordinator? else { return }
        
        let tabs = [mainTab,historyTab]
        self.tabs = tabs
    }
    
    func start() {
        tabBarController.viewControllers = tabs.map { $0.rootController }
        window?.makeKeyAndVisible()
    }
}

