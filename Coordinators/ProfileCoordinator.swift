//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Dmitrii KRY on 22.03.2021.
//

import Foundation
import UIKit

class ProfileCoordinator: Coordinator {
    
    var navController: UINavigationController?
    var viewController: UIViewController

    init() {

        viewController = ProfileViewController()
        viewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "person"), tag: 1)
        navController = UINavigationController(rootViewController: viewController)
    }
    
    func start() {
    }

}
