//
//  CustomAction.swift
//  GenieApp
//
//  Created by K A Aneesh on 26/11/21.
//

import UIKit
import Network



struct CustomAction {
    
    let title: String
    let style: UIAlertAction.Style
    
    init(title: String,style: UIAlertAction.Style = .default){
        self.title = title
        self.style = style
    } 
    static let okAction: CustomAction = .init(title: kOkay,style: .default)
    static let cancelAction: CustomAction = .init(title: kCancel,style: .cancel)
    static let logOutAction: CustomAction = .init(title: kLogout,style: .destructive)
}

 
