//
//  Extension+ViewController.swift
//  GenieApp
//
//  Created by K A Aneesh on 26/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: - Show Alert
    func showAlert(title: String,message: String,alertStyle: UIAlertController.Style = .alert,actions: [CustomAction],completionHandler: @escaping((_ action: CustomAction) -> ())){
        let alertController = UIAlertController(title: title,message: message,preferredStyle: alertStyle)
        for action in actions {
            let alertAction = UIAlertAction(title: action.title,style:  action.style) {(actionTapped) in
                completionHandler(action)
            }
            alertController.addAction(alertAction)
        }
        self.present(alertController, animated: true, completion: {})
    }
    
    func showAlert(title: String, message: String, completed: (() -> ())? = nil ) {
        showAlert(title: title, message: message, actions: [.okAction]) {(_) in
            if let completed = completed{
                completed()
            }
        }
    }
    
    class var storyboardID: String {
        return "\(self)"
    }

    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
   
}

