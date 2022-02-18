//
//  HistoryTabCoordinator.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 31.01.2022.
//

import UIKit

class HistoryTabCoordinator: TabCoordinator {
    var rootController: UIViewController
    var tabBarItem: UITabBarItem = UITabBarItem(title: "History", image: UIImage(named: "list.bullet"), tag: 2)
    
    var historyVC: HistoryViewController
    lazy var completionHandler = historyVC.completion
    
    init() {
        historyVC = HistoryViewController()
        historyVC.viewModel = HistoryViewModel()
        rootController = UINavigationController(rootViewController: historyVC)
        rootController.tabBarItem = tabBarItem
        historyVC.navigationController?.navigationBar.prefersLargeTitles = true
        historyVC.navigationItem.title = "History"
    }
}
