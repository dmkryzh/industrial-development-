//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post? {
        didSet {
            title = post?.title
        }
    }
    
    func optionalTry() throws {
        if let title = self.post?.title, title == "Пост" {
            print("Author is \(title)")
        } else {
            throw AppErrors.internalError
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        if let _ = try? optionalTry() {
            print("No issues")
        } else {
            print("Some error")
        }
    }
}
