//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Dmitrii KRY on 22.03.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator  {

    var rootViewController: UIViewController
    var navController: UINavigationController?

    init(window: UIWindow, vc: UIViewController) {
        rootViewController = vc
        navController = rootViewController.navigationController
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func start() {
    }

}
