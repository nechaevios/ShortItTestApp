//
//  TabCoordinatorProtocols.swift
//  ShortIt
//
//  Created by Nechaev Sergey  on 02.02.2022.
//

import UIKit

protocol TabCoordinator: AnyObject {
    var rootController: UIViewController { get }
    var tabBarItem: UITabBarItem { get }
}

protocol ChildrenViewCompletionProtocol {
    var completion: ((_: String) -> ())? { get }
}

extension ChildrenViewCompletionProtocol {
    var completion: ((_: String) -> ())? {
        return { inputText in
            print(inputText)
        }
    }
}
