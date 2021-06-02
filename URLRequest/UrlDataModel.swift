//
//  UrlDataModel.swift
//  Navigation
//
//  Created by Dmitrii KRY on 09.05.2021.
//

import Foundation

struct UserStructure {
    
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    init?(json: [String: Any]?) {
        guard let userId = json?["userId"] as? Int,
              let id = json?["id"] as? Int,
              let title = json?["title"] as? String,
              let completed = json?["completed"] as? Bool
        else {
            return nil
        }
        
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
}

struct Planet: Codable {
    
    var name: String
    var rotationPeriod: String
    var orbitalPeriod: String
    var diameter: String
    var climate: String
    var gravity: String
    var terrain: String
    var surfaceWater: String?
    var population: String
    var residents: [String]
    var films: [String]
    var created: String
    var edited: String
    var url: URL
}

struct Person: Codable {
    let name: String
}

