//
//  PostViewController.swift
//  Navigation
//

import UIKit
import SnapKit

class PostViewController: UIViewController {
    
    var post: Post? {
        didSet {
            title = post?.title
        }
    }
    
    var url: URL? {
        
        didSet {
            
            NetworkService.dataTask(url: url!, completionData: { data in
                DispatchQueue.main.async {
                    self.responseLabel.text = data
                }
            },
            completionResponse: { httpHeaders in
                DispatchQueue.main.async {
                    self.htmlHeadersLabel.text = httpHeaders?.description
                }
            },
            completionCode: { code in
                DispatchQueue.main.async {
                    self.statusCodeLabel.text = String(code!)
                }
            })
        }
        
    }
    
    lazy var statusCodeLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    lazy var htmlHeadersLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    lazy var responseLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    lazy var constraintsSetup = { [self] in
        statusCodeLabel.snp.makeConstraints() { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        htmlHeadersLabel.snp.makeConstraints() { make in
            make.top.equalTo(statusCodeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        responseLabel.snp.makeConstraints() { make in
            make.top.equalTo(htmlHeadersLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
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
        view.addSubviews(statusCodeLabel, htmlHeadersLabel, responseLabel)
        if let _ = try? optionalTry() {
            print("No issues")
        } else {
            print("Some error")
        }
        constraintsSetup()
        
    }
}
