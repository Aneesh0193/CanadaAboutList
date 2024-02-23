//
//  Enum.swift
//
//  Created by Aneesh on 26/11/21.
//

import Foundation
import UIKit

 
enum AppStoryboard: String {
    
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
 
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError(kIdentifierNotFound)
        }
        
        return scene
    }
 
    func initialViewController() -> UIViewController? {
 
        return instance.instantiateInitialViewController()
    }
}

enum HTTPRequestMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

enum ResponseStatus: Int {
    case successCreation = 201
    case success = 200
    case successDeletion = 204
    case unAuthorized = 401
}

enum ImageAsset : String {
    case room = "home-office"
    case contact = "contact-book"
}

enum NetworkError {
    case invalidURL
    case responseError
    case unknown
}

 
