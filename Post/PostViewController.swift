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
    
    var persons: [Person]? {
        didSet {
            tableViewNames.reloadData()
        }
    }
    
    var post: Post? {
        didSet {
            title = post?.title
        }
    }
    
    var objectForShow: String?
    
    var objectForTable: Planet? {
        didSet {
            objectForTable?.residents.forEach() { resident in
                NetworkService.dataTask(
                    url: (URL(string: resident)!),
                    
                    completionData: { data in
                        DispatchQueue.main.async { [self] in
                            let person = try? decoder.decode(Person.self, from: data!)
                            
                            if self.persons != nil {
                                self.persons?.append(person!)
                            } else {
                                self.persons = [person!]
                            }
                        }
                    },
                    
                    completionResponse: nil,
                    
                    completionError: nil)
            }
        }
    }
    
    var randomUrl: URL? {
        
        didSet {
            
            NetworkService.dataTask(url: randomUrl!,
                                    
                                    completionData: { [self] data in
                                        
                                        DispatchQueue.main.async {
                                            
                                            if objectForShow == "sample" {
                                                let json = try? NetworkService.toObject(json: data!)
                                                let user = UserStructure(json: json)
                                                formatedLabel.text = user?.title
                                                
                                            } else if objectForShow == "planet" {
                                                let planet = try? decoder.decode(Planet.self, from: data!)
                                                objectForTable = planet
                                                orbitalLabel.text = planet?.orbitalPeriod
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
    
    lazy var tableViewNames: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
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
        
        tableViewNames.snp.makeConstraints() { make in
            make.height.equalTo(300)
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
        containerView.addSubviews(statusHeader, statusCodeLabel, headerHeader, htmlHeadersLabel, responseHeader, responseLabel, formatedHeader, formatedLabel, orbitalHeader, orbitalLabel, tableViewNames)
        if let _ = try? optionalTry() {
            print("No issues")
        } else {
            print("Some error")
        }
        constraintsSetup()
    }
    
}

extension PostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.textAlignment = .center
    }
    
}

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = persons else { return 0 }
        return persons!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        guard let _ = persons else { return UITableViewCell.init(frame: .zero) }
        
        cell.textLabel?.text = "№\(indexPath.item + 1) - \(self.persons![indexPath.item].name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Residents names"
    }
    
}


