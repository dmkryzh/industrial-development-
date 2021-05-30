//
//  Post+CoreDataProperties.swift
//  Navigation
//
//  Created by Dmitrii KRY on 28.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var postName: String?
    @NSManaged public var postPic: String?

}

extension Post : Identifiable {

}
