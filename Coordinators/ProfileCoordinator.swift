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
    var rootViewController: UIViewController

    init() {
        rootViewController = ProfileViewController()
        rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), tag: 1)
        navController = UINavigationController(rootViewController: rootViewController)
    }
    
    func start() {}

}
