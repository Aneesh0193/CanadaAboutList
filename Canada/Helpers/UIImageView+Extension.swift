//
//  UIImageView+Extension.swift
//  ClothesStore
//
//  Created by Aneesh 2 on 25/08/2022.
//  Copyright © 2022 RichieHope. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                 self.image = UIImage(data: data)
             }
          }
       }).resume()
    }
}

 
