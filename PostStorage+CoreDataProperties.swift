//
//  PostStorage+CoreDataProperties.swift
//  Navigation
//
//  Created by Dmitrii KRY on 29.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension PostStorage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostStorage> {
        return NSFetchRequest<PostStorage>(entityName: "PostStorage")
    }

    @NSManaged public var likes: String
    @NSManaged public var author: String
    @NSManaged public var views: String
    @NSManaged public var title: String
    @NSManaged public var image: String
    @NSManaged public var postDescription: String

}

extension PostStorage : Identifiable {

}
