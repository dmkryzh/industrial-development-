//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Dmitrii KRY on 14.08.2021.

import Foundation
import LocalAuthentication
import UIKit

class LocalAuthorizationService: UIViewController {
  
    let contet = LAContext()
    let reason = "To access user data"
    var authError: NSError?
    
    func authorizeIfPossible(_ isAuthorizationFinished: @escaping (Bool) -> Void) {

        if contet.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            contet.localizedCancelTitle = "Cancel"
            contet.localizedFallbackTitle = ""
            contet.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evaluateError in
                DispatchQueue.main.async {
                    if success {
                        isAuthorizationFinished(true)
                    } else {
                        print(evaluateError?.localizedDescription as Any)
                    }
                }
            }
        } else {
            print("Sorry, can't evaluate policy. \(String(describing: authError?.localizedDescription))")
        }
    }
    
   func biometricType() -> BiometricType {
    
        if #available(iOS 11, *) {
            let _ = contet.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(contet.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            @unknown default:
                fatalError("Not supported authentification type")
            }
        } else {
            return contet.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }

    enum BiometricType {
        case none
        case touch
        case face
    }
    
}
