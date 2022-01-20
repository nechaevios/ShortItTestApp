//
//  TabBarViewController.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 15.01.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarUI()
        setupVCs()
    }
    
    private func setupTabBarUI() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    private func setupVCs() {
        viewControllers = [
            createNavController(
                for: MainViewController(),
                   title: "Shorten now",
                   image: UIImage(named: "lasso.and.sparkles")!
            ),
            createNavController(
                for: HistoryViewController(),
                   title: "History",
                   image: UIImage(named: "list.bullet")!
            )
        ]
    }
    
}
