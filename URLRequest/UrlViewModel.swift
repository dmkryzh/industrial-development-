//
//  UrlViewModel.swift
//  Navigation
//
//  Created by Dmitrii KRY on 13.05.2021.
//

import Foundation

protocol PostInput {
    func reloadLabels()
    func reloadTables()
}

class UrlViewModel {
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    var reloadData: PostInput?
    
    var htmlHeaders: String?
    
    var response: String?
    
    var title: String?
    
    var orbital: String?
    
    var post: Post
    
    var randomUrl: URL
    
    var objectForShow: String?
    
    var statusCode: String?
    
    var persons: [Person]?
    
    var objectForTable: Planet? {
        didSet {
            updateResidentsTable()
        }
    }
    
    func updateResidentsTable() {
        
        objectForTable?.residents.forEach { resident in
            guard let url = URL(string: resident) else { return }
            NetworkService.dataTask(
                url: url,
                
                completionData: { [self] data in
                    guard let data = data else { return }
                    guard let person = try? decoder.decode(Person.self, from: data) else { return }
                    (persons?.append(person)) ?? (persons = [person])
                    reloadData?.reloadTables()
                    
                },
                
                completionResponse: { [self] httpHeaders, httpCode in
                    
                    htmlHeaders = httpHeaders?.description
                    statusCode = httpCode.description
                    reloadData?.reloadLabels()
                    
                },
                
                completionError: { [self] error in
                    response = error?.debugDescription
                })
            
            
            
        }
    }
    
    func udateLabels() {
        
        NetworkService.dataTask(url: self.randomUrl,
                                
                                completionData: { [self] data in
                                    
                                    if objectForShow == "sample" {
                                        let json = try? NetworkService.toObject(json: data!)
                                        let user = UserStructure(json: json)
                                        title = user?.title
                                        
                                    } else if objectForShow == "planet" {
                                        let planet = try? decoder.decode(Planet.self, from: data!)
                                        objectForTable = planet
                                        orbital = planet?.orbitalPeriod
                                    }
                                    response = String(data: data!, encoding: .utf8)
                                    
                                },
                                
                                completionResponse: { [self] httpHeaders, httpCode in
                                    
                                    htmlHeaders = httpHeaders?.description
                                    statusCode = httpCode.description
                                    reloadData?.reloadLabels()
                                    
                                },
                                
                                completionError: { [self] error in
                                    
                                    response = error?.debugDescription
                                    
                                })
    }
    
    init(post: Post, objectToShow: String?, url: URL ) {
        self.post = post
        self.objectForShow = objectToShow
        self.randomUrl = url
    }
    
}

