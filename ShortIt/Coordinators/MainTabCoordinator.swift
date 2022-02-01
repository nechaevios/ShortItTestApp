//
//  MainTabCoordinator.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 31.01.2022.
//

import UIKit

class MainTabCoordinator: TabCoordinator {
    
    var rootController: UIViewController
    var tabBarItem: UITabBarItem = UITabBarItem(title: "Short It", image: UIImage(named: "lasso.and.sparkles"), tag: 1)
    
    init() {
        let mainVC = MainViewController()
        mainVC.viewModel = MainViewModel()
        
        rootController = UINavigationController(rootViewController: mainVC)
        rootController.tabBarItem = tabBarItem
//        rootController.navigationItem.
    }
}
