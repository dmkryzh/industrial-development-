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
    var rootViewController: UIViewController

    init() throws {
        rootViewController = FeedViewController()
        rootViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "house"), tag: 0)
        navController = UINavigationController(rootViewController: rootViewController)
        guard navController != nil else { throw AppErrors.internalError }
    }
    
    func start() {
    }

}
