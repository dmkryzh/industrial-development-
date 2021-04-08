//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Dmitrii KRY on 21.03.2021.
//

import Foundation
import UIKit

enum AppErrors: String, Error {
    case internalError = "Some internal error"
    case unauthenticated = "User is unauthenticated"
}

class MainTabBarController: UITabBarController {

    let feed: FeedCoordinator = {
       let feed = try? FeedCoordinator()
        precondition(feed != nil, "No sense")
        return feed!
    }()
    
    let login = LoginCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [feed.navController!, login.navController!]

    }

}

