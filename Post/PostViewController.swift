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
            
            NetworkService.dataTask(url: url!,
            
            completionData: { data in
                DispatchQueue.main.async {
                    self.responseLabel.text = data
                }
            },
            completionResponse: { httpHeaders, httpCode in
                DispatchQueue.main.async {
                    self.htmlHeadersLabel.text = httpHeaders?.description
                    self.statusCodeLabel.text = httpCode.description
                }
            },
            completionError: { error in
                DispatchQueue.main.async {
                    self.responseLabel.text = error?.debugDescription
                }
            })
        }
        
    }
    
    let statusHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "HTTP status:"
        return label
    }()
    
    let responseHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "HTTP response:"
        return label
    }()
    
    let headerHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "HTTP headers:"
        return label
    }()
    
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
        
        statusHeader.snp.makeConstraints() { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        statusCodeLabel.snp.makeConstraints() { make in
            make.top.equalTo(statusHeader.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        headerHeader.snp.makeConstraints() { make in
            make.top.equalTo(statusCodeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        htmlHeadersLabel.snp.makeConstraints() { make in
            make.top.equalTo(headerHeader.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        responseHeader.snp.makeConstraints() { make in
            make.top.equalTo(htmlHeadersLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        responseLabel.snp.makeConstraints() { make in
            make.top.equalTo(responseHeader.snp.bottom).offset(10)
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
        view.addSubviews(statusHeader, statusCodeLabel, headerHeader, htmlHeadersLabel, responseHeader, responseLabel)
        if let _ = try? optionalTry() {
            print("No issues")
        } else {
            print("Some error")
        }
        constraintsSetup()
        
    }
}
