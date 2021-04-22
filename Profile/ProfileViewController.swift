//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий on 21.12.2020.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    var someState = true
    
    var center: CGPoint?
    
    lazy var header: ProfileHeaderView = {
        let header = ProfileHeaderView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(avaTap))
        header.avaView.isUserInteractionEnabled = true
        header.avaView.addGestureRecognizer(gesture)
        return header
    }()
    
    lazy var cross: UIImageView = {
        let cross = UIImageView()
        let crossConfig = UIImage.SymbolConfiguration(textStyle: .largeTitle)
        cross.image = UIImage(systemName: "xmark", withConfiguration: crossConfig)
        cross.alpha = 0
        cross.tintColor = .white
        cross.isUserInteractionEnabled = true
        let crossGesture = UITapGestureRecognizer(target: self, action: #selector(crossTap))
        cross.addGestureRecognizer(crossGesture)
        return cross
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        return tableView
    }()
    
    //MARK: Анимация
    
    func animateCross(_ state: Bool, _ completion: ((Bool)->Void)? = nil) {
        if state {
            UIView.animate(withDuration: 1.0, animations: {
                self.cross.alpha = 1
                self.view.bringSubviewToFront(self.cross)
            },
            completion: completion)
            
        } else {
            UIView.animate(withDuration: 1.0, animations: {
                self.cross.alpha = 0
            },
            completion: completion)
        }
    }
    
    @objc func avaTap() {
        
        guard someState else { return }
        
        func animateAvaToCenterProfile() {
            
            self.header.grayView.alpha = 0.5
            
            self.header.avaView.layer.cornerRadius = 0
            
            self.header.avaView.snp.remakeConstraints() { make in
                make.center.equalTo(self.view.safeAreaLayoutGuide.snp.center)
                make.width.height.equalTo(self.view.safeAreaLayoutGuide.snp.width)
            }
            
            self.view.layoutIfNeeded()
            self.view.addSubviews(self.header.grayView, self.header.avaView)
        }
        
        UIView.animate(withDuration: 1.0, animations: animateAvaToCenterProfile) {
            if $0 {
                self.animateCross(true)
            }
        }
        
        someState.toggle()
    }
    
    
    @objc func crossTap() {
        
        guard someState == false else { return }
        
        let grayBackgroundProfile = self.view.subviews[self.view.subviews.count - 3]
        
        let avaPositionProfile = self.view.subviews[self.view.subviews.count - 2]
        
        func animateAvaToInitialSize() {
            
            avaPositionProfile.layer.cornerRadius = 50
            grayBackgroundProfile.alpha = 0
            
            avaPositionProfile.snp.remakeConstraints() { make in
                make.height.width.equalTo(100)
                make.center.equalTo(self.header.avaContainer.snp.center)
            }
            
            self.view.layoutIfNeeded()
            self.header.addSubviews(grayBackgroundProfile, avaPositionProfile)
        }
        
        animateCross(false) {
            if $0 {
                UIView.animate(withDuration: 1.0, animations: animateAvaToInitialSize) {
                    if $0 {
                        avaPositionProfile.snp.remakeConstraints() { make in
                            make.height.width.equalTo(100)
                            make.center.equalTo(self.header.avaContainer.snp.center)
                        }
                        self.tableView.reloadData()
                    }
                }
            }
        }
        someState.toggle()
    }
    
    //MARK: Constraints
    
    func setupConstraints() {
        tableView.snp.makeConstraints() { make in
            make.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        cross.snp.makeConstraints() { make in
            make.top.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(60)
        }
    }
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubviews(tableView, cross)
        setupConstraints()
        //center = self.ava.center
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
}

// MARK: UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 16
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .lightGray
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        let photosViewController = PhotosViewController()
        photosViewController.title = "Photo Gallery"
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        return self.header
    }
    
    
    
}

// MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return PostItems.tableStruct.count
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cellFromPhoto: PhotosTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as! PhotosTableViewCell
            return cellFromPhoto
        case 1:
            let cellFromPost: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
            cellFromPost.post = PostItems.tableStruct[indexPath.row]
            return cellFromPost
        default:
            return UITableViewCell(frame: .zero)
        }
    }
    
}
