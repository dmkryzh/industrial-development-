//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

protocol FeedViewOutput {
    func showPost()
    var navigationController: UINavigationController? { get set }
    var postName: Post? { get set }
}

class FeedViewController: UIViewController {
    
    let post: Post = Post(title: "Пост", author: nil, description: nil, imageName: nil, likes: nil, views: nil)
    
    var output: FeedViewOutput?
    
    lazy var containerView: UIView = {
        let container = ContainerView()
        container.onTap = output?.showPost
        return container
    }()
    
    func setupConstraints() {
        containerView.snp.makeConstraints() { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        output = PostPresenter()
        output?.navigationController = navigationController
        output?.postName = post
        view.addSubview(containerView)
        setupConstraints()
        print(type(of: self), #function)
        
    }

}

//MARK: ContainerView
class ContainerView: UIView {
    
    var onTap: (() -> Void)?
    
    let newButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("button1", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(navigationTo), for: .touchUpInside)
        return button
    }()
    
    let secondNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("button2", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(navigationTo), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonsStack: UIStackView = {
        let buttonsStack = UIStackView()
        buttonsStack.addArrangedSubview(newButton)
        buttonsStack.addArrangedSubview(secondNewButton)
        buttonsStack.alignment = .fill
        buttonsStack.distribution = .fillEqually
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 0
        buttonsStack.layer.cornerRadius = 10
        buttonsStack.layer.masksToBounds = true
        buttonsStack.toAutoLayout()
        return buttonsStack
    }()
    
    lazy var newConstraints = [
        buttonsStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        buttonsStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        buttonsStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ]
    
    @objc private func navigationTo() {
        guard onTap != nil else { return }
        onTap!()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(buttonsStack)
        NSLayoutConstraint.activate(newConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: PostPresenter
class PostPresenter: FeedViewOutput {
    
    func showPost() {
        let postViewController = PostViewController()
        postViewController.post = postName
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    var navigationController: UINavigationController?
    var postName: Post?
}

