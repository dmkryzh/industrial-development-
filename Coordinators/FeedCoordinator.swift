//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Dmitrii KRY on 22.03.2021.
//

import Foundation
import UIKit

class FeedCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navController: UINavigationController
    var post: Post = Post(title: "Пост", author: nil, description: nil, imageName: nil, likes: nil, views: nil)

    init(navigation: UINavigationController) {
        navController = navigation

    }
    
    func start() {
        let feed = FeedViewController()
        feed.coordinator = self
        navController.pushViewController(feed, animated: true)
    }
    
    func startNavigationToRandomUrl() {
        
        let postVm = PostViewModel(post: post, objectToShow: nil, url: NetworkService.appConf!)
        let postVc = PostViewController(viewModel: postVm)
        navController.pushViewController(postVc, animated: true)
        
    }
    
    func startNavigationToUrl() {

        let postVm = PostViewModel(post: post, objectToShow: "sample", url: URL(string: "https://jsonplaceholder.typicode.com/todos/1")!)
        let postVc = PostViewController(viewModel: postVm)
        navController.pushViewController(postVc, animated: true)
        
    }
    
    func startNavigationToPlanetUrl() {

        let postVm = PostViewModel(post: post, objectToShow: "planet", url: URL(string: "https://swapi.dev/api/planets/1")!)
        let postVc = PostViewController(viewModel: postVm)
        navController.pushViewController(postVc, animated: true)
        
    }
    
    func startNavigationToPlayer() {
        let musicVc = MusicViewController()
        navController.pushViewController(musicVc, animated: true)
        
    }
    

}
