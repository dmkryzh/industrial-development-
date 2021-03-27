//
//  Coordinator.swift
//  Navigation
//
//  Created by Dmitrii KRY on 22.03.2021.
//

import Foundation
import UIKit

protocol Coordinator: class {
    
    var rootViewController: UIViewController { get }
    var navController: UINavigationController? { get }
    func start()
    
}

