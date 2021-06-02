//
//  ViewController.swift
//  Navigation
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
    let newButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("JSONSerialization example", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(navigationToRandomUrl), for: .touchUpInside)
        return button
    }()
    
    let secondNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Codable example", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(navigationToUrl), for: .touchUpInside)
        return button
    }()
    
    let someNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Decoder with table", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.addTarget(self, action: #selector(navigationToPlanetUrl), for: .touchUpInside)
        return button
    }()
    
    let thirdNewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Music", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(navigationToPlayer), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonsStack: UIStackView = {
        let buttonsStack = UIStackView(arrangedSubviews: [newButton, secondNewButton,someNewButton, thirdNewButton])
        buttonsStack.alignment = .fill
        buttonsStack.distribution = .fillEqually
        buttonsStack.axis = .vertical
        buttonsStack.spacing = 0
        buttonsStack.layer.cornerRadius = 10
        buttonsStack.layer.masksToBounds = true
        return buttonsStack
    }()
    
    func newConstraints() {
        buttonsStack.snp.makeConstraints() { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(16)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    @objc private func navigationToRandomUrl() {
        coordinator?.startNavigationToRandomUrl()
    }
    
    @objc private func navigationToUrl() {
        coordinator?.startNavigationToUrl()
  
    }
    
    @objc private func navigationToPlanetUrl() {
        coordinator?.startNavigationToPlanetUrl()
    }
    
    @objc private func navigationToPlayer() {
        coordinator?.startNavigationToPlayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(buttonsStack)
        newConstraints()

    }
    
}
