//
//  ViewController.swift
//  Navigation
//

import UIKit
import SnapKit

//protocol FeedViewOutput {
//    func showPost(post: Post, url: URL?, object: String?)
//    func showPlayer()
//    var navigationController: UINavigationController? { get set }
//}

class FeedViewController: UIViewController {
    
    weak var coordinator: FeedCoordinator?
    
   // var output: FeedViewOutput?

//    lazy var containerView: UIView = {
//        let container = ContainerView()
//        container.onTap = output?.showPost(post:url:object:)
//        container.testOnTap = output?.showPlayer
//        return container
//    }()
    
//    func setupConstraints() {
//        containerView.snp.makeConstraints() { make in
//            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
    
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
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addSubview(buttonsStack)
//        newConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(buttonsStack)
        newConstraints()

    }
    
}


//MARK: ContainerView
//
//class ContainerView: UIView {
//
//    let post: Post = Post(title: "Пост", author: nil, description: nil, imageName: nil, likes: nil, views: nil)
//
//    var onTap: ((Post, URL?, String?) -> Void)?
//
//    var testOnTap: (() -> Void)?
    
//    let newButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("JSONSerialization example", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemBlue
//        button.addTarget(self, action: #selector(navigationToRandomUrl), for: .touchUpInside)
//        return button
//    }()
//
//    let secondNewButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Codable example", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemRed
//        button.addTarget(self, action: #selector(navigationToUrl), for: .touchUpInside)
//        return button
//    }()
//
//    let someNewButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Decoder with table", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemYellow
//        button.addTarget(self, action: #selector(navigationToPlanetUrl), for: .touchUpInside)
//        return button
//    }()
//
//    let thirdNewButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Music", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemPink
//        button.addTarget(self, action: #selector(navigationToPlayer), for: .touchUpInside)
//        return button
//    }()
//
//    lazy var buttonsStack: UIStackView = {
//        let buttonsStack = UIStackView(arrangedSubviews: [newButton, secondNewButton,someNewButton, thirdNewButton])
//        buttonsStack.alignment = .fill
//        buttonsStack.distribution = .fillEqually
//        buttonsStack.axis = .vertical
//        buttonsStack.spacing = 0
//        buttonsStack.layer.cornerRadius = 10
//        buttonsStack.layer.masksToBounds = true
//        return buttonsStack
//    }()
//
//    func newConstraints() {
//        buttonsStack.snp.makeConstraints() { make in
//            make.leading.equalToSuperview().offset(16)
//            make.trailing.equalToSuperview().inset(16)
//            make.centerY.equalToSuperview()
//        }
//    }
//
//    @objc private func navigationToRandomUrl() {
//        guard onTap != nil else { return }
//        onTap!(post, NetworkService.appConf, nil)
//    }
//
//    @objc private func navigationToUrl() {
//        guard onTap != nil else { return }
//        onTap!(post, URL(string: "https://jsonplaceholder.typicode.com/todos/1"), "sample")
//    }
//
//    @objc private func navigationToPlanetUrl() {
//        guard onTap != nil else { return }
//        onTap!(post, URL(string: "https://swapi.dev/api/planets/1"), "planet")
//    }
//
//    @objc private func navigationToPlayer() {
//        guard testOnTap != nil else { return }
//        testOnTap!()
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.addSubview(buttonsStack)
//        newConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
//
//MARK: PostPresenter
//class PostPresenter: FeedViewOutput {
//
//    func showPost(post: Post, url: URL?, object: String?) {
//        let postViewController = PostViewController()
//        postViewController.randomUrl = url
//        postViewController.objectForShow = object
//        postViewController.post = post
//        navigationController?.pushViewController(postViewController, animated: true)
//    }
//
//    func showPlayer() {
//        let playerView = MusicViewController()
//        navigationController?.pushViewController(playerView, animated: true)
//    }
//
//    var navigationController: UINavigationController?
//
//}

