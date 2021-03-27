//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Dmitrii KRY on 26.03.2021.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    var navController: UINavigationController?
    
    init() {
        let vc = LogInViewController()
        rootViewController = vc
        rootViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "person"), tag: 1)
        navController = UINavigationController(rootViewController: rootViewController)
        vc.coordinator = self
    }
    
    func start() {}
    
    func startFeed() {
        let feed = ProfileViewController()
        navController?.show(feed, sender: nil)
    }
    
    
}
