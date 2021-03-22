//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Dmitrii KRY on 22.03.2021.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {

    var navController: UINavigationController?
    var viewController: UIViewController

    init() {
        viewController = FeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "house"), tag: 0)
        navController = UINavigationController(rootViewController: viewController)
    }
    
    func start() {
    }

}
