//
//  PhotosViewModel.swift
//  Navigation
//
//  Created by Dmitrii KRY on 02.05.2021.
//

import Foundation
import UIKit

protocol PhotosViewModelDelegate {
    func updateTimerString(fieldToUpdate: inout String?)
}

class PhotosViewModel {
    
    private class TestResult {
        var property: String
        init(property: String) {
            self.property = property
        }
    }
    
    private(set) var date = Date()
    
    private(set) var timer: Timer?
    
    private(set) var photos: [Photo]
    
    private(set) var numberOfSections: Int
    
    private(set) var numberOfItems: Int
    
    private(set) var collectionIdentifier: String
    
    private func testResult(completion: (Result<TestResult, AppErrors>) -> Void) {
        if let _ = timer {
            completion(.success(TestResult(property: "Result OK")))
        } else {
            completion(.failure(AppErrors.internalError))
        }
    }
 
    func timerString(propagateTo: inout String?) {
        
        let time = Date().timeIntervalSince(date)
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        var times: [String] = []
        if hours > 0 {
            times.append("\(hours)h")
        }
        if minutes > 0 {
            times.append("\(minutes)m")
        }
        times.append("\(seconds)s")
        
        propagateTo = times.joined(separator: " ")
        
    }
    
    func toUpdatekWithTimeInterval ( timeInterval: TimeInterval, closure: @escaping ()->Void ) {
        
        testResult() { result in
              switch result {
              case .success(let test):
                  print(test.property)
              case .failure(let error):
                  print(error.rawValue)
              }
          }
        
        if timer == nil {
            date = Date()
            timer = Timer(timeInterval: timeInterval, repeats: true) {  _ in
                closure()
            }
            RunLoop.current.add(timer!, forMode: .common)
            
        } else {
            timer!.invalidate()
            timer = nil
        }

    }
    
    init(numberOfSections: Int, collectionIdentifier: String, photoSet: [Photo]) {
        photos = photoSet
        self.numberOfSections = numberOfSections
        self.numberOfItems = photos.count
        self.collectionIdentifier = collectionIdentifier
    }
    
}
