//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Dmitrii KRY on 22.03.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator  {

    var viewController: UIViewController = MainTabBarController()
    var navController: UINavigationController?

    init(window: UIWindow) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func start() {
    }

}
