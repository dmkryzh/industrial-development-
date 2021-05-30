//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by Dmitrii KRY on 23.03.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit



class ProfileViewModel {
    
    var coreData: CoreDataStack
    
    func saveLikedPost(_ post: Post) {
        coreData.createNewTask(content: post)
    }
    
    func loadLikedPost() -> [PostStorage] {
        let posts = coreData.fetchTasks()
        return posts
    }
    
    init(coreData: CoreDataStack) {
        self.coreData = coreData
    }
    
}
