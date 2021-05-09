//
//  PostViewController.swift
//  Navigation
//

import UIKit
import SnapKit

class PostViewController: UIViewController {
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        return tableView
    }()
    
    var post: Post? {
        didSet {
            title = post?.title
        }
    }
    
    var object: String?
    
    var objectForTable: Int?
    var someObjectForTable: Planet?
    
    var randomUrl: URL? {
        
        didSet {
            
            NetworkService.dataTask(url: randomUrl!,
                                    
                                    completionData: { [self] data in
                                        DispatchQueue.main.async {
                                            
                                            if object == "simple" {
                                                let sample = SampleStructure(json: try! NetworkService.toObject(json: data!)!)!
                                                formatedLabel.text = sample.title
                                            } else if object == "planet" {
                                                let planet = try! decoder.decode(Planet.self, from: data!)
                                                someObjectForTable = planet
                                                objectForTable = planet.residents.count
                                                orbitalLabel.text = planet.orbitalPeriod
                                                
                                            }
                                            responseLabel.text = String(data: data!, encoding: .utf8)
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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
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
    
    let formatedHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "Title:"
        return label
    }()
    
    let orbitalHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.text = "Orbital period:"
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
    
    lazy var formatedLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFill
        return label
    }()
    
    lazy var orbitalLabel: UILabel = {
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
        
        scrollView.snp.makeConstraints() { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        containerView.snp.makeConstraints() { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
        
        statusHeader.snp.makeConstraints() { make in
            make.top.equalTo(containerView.snp.top).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        statusCodeLabel.snp.makeConstraints() { make in
            make.top.equalTo(statusHeader.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        headerHeader.snp.makeConstraints() { make in
            make.top.equalTo(statusCodeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        htmlHeadersLabel.snp.makeConstraints() { make in
            make.top.equalTo(headerHeader.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        responseHeader.snp.makeConstraints() { make in
            make.top.equalTo(htmlHeadersLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        responseLabel.snp.makeConstraints() { make in
            make.top.equalTo(responseHeader.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        formatedHeader.snp.makeConstraints() { make in
            make.top.equalTo(responseLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        formatedLabel.snp.makeConstraints() { make in
            make.top.equalTo(formatedHeader.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        orbitalHeader.snp.makeConstraints() { make in
            make.top.equalTo(formatedLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        orbitalLabel.snp.makeConstraints() { make in
            make.top.equalTo(orbitalHeader.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
        }
        
        tableView.snp.makeConstraints() { make in
            make.top.equalTo(orbitalLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerView).inset(10)
            make.bottom.equalTo(containerView.snp.bottom).inset(10)
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
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(statusHeader, statusCodeLabel, headerHeader, htmlHeadersLabel, responseHeader, responseLabel, formatedHeader, formatedLabel, orbitalHeader, orbitalLabel, tableView)
        if let _ = try? optionalTry() {
            print("No issues")
        } else {
            print("Some error")
        }
        constraintsSetup()
        
    }
}

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Name: \(NetworkService.dataTask(url: (someObjectForTable?.residents[indexPath.item])!, completionData: nil, completionResponse: nil, completionError: nil))"
   
        cell.textLabel?.textAlignment = .left
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objectForTable ?? 0
    }
    
    
    
}
