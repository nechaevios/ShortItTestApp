//
//  TabBarViewController.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 15.01.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private var viewModel: TabBarViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = TabBarViewModel()
        
        setupTabBarUI()
        setupVCs()
    }
    
    private func setupTabBarUI() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    private func setupVCs() {
        let tabBarCells = viewModel.getTabBarCells()
        var tabBarViewControllers: [UIViewController] = []

        for tabBarCell in tabBarCells {
            guard let viewController = tabBarCell.viewController as? UIViewController else { return }
            guard let cellImage = UIImage(named: tabBarCell.viewControllerImageName) else { return }
            let navController = createNavController(
                for: viewController,
                   title: tabBarCell.viewControllerTitle,
                   image: cellImage
            )
            tabBarViewControllers.append(navController)
        }
        
        self.setViewControllers(tabBarViewControllers, animated: false)
    }
    
}
