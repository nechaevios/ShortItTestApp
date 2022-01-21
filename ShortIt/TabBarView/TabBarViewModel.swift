//
//  TabBarViewModel.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 21.01.2022.
//

import Foundation

struct TabBarCell {
    let viewController: NSObject
    let viewControllerTitle: String
    let viewControllerImageName: String
}

protocol TabBarViewModelProtocol {
    func getTabBarCells() -> [TabBarCell]
}

final class TabBarViewModel: TabBarViewModelProtocol {
    private let firstVC = MainViewController()
    private let secondVC = HistoryViewController()
    
    func getTabBarCells() -> [TabBarCell] {
        let mainVC = TabBarCell(viewController: firstVC, viewControllerTitle: "Short It", viewControllerImageName: "lasso.and.sparkles")
        let historyVC = TabBarCell(viewController: secondVC, viewControllerTitle: "History", viewControllerImageName: "list.bullet")
        
        return  [mainVC, historyVC]
    }
}
