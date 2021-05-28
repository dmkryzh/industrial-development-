//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Dmitrii KRY on 26.05.2021.
//

import Foundation
import UIKit
import SnapKit

class FavoriteViewController: UIViewController {
    
    var viewModel: FavoriteVM
    
    weak var coordinator: FavoriteCoordrinator?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.toAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        return tableView
    }()
    
    func setupConstraints() {
        tableView.snp.makeConstraints() { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    init(vm: FavoriteVM) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(tableView)
        view.backgroundColor = .lightGray
        setupConstraints()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PostItems.tableStruct.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellFromPost: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        cellFromPost.post = PostItems.tableStruct[indexPath.row]
        return cellFromPost
    }
    
}

extension FavoriteViewController: UITableViewDelegate {

}
