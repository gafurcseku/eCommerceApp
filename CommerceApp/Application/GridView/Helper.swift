//
//  Helper.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import Foundation
struct Helper {
    
     static func getImage(imageString:String) -> URL? {
         if imageString.hasPrefix("http") {
             if  let imageUrl = URL(string: imageString) {
                 return imageUrl
             }else {
                 return  nil
             }
         }else if imageString.hasPrefix("https") {
             if  let imageUrl = URL(string: imageString) {
                 return imageUrl
             }else {
                 return  nil
             }
         }else {
             if  let imageUrl = URL(string: imageString) {
                 return imageUrl
             }else {
                 print(imageString)
                 return  nil
             }
         }
     }
    
    static func setImage(to image:Data) {
            UserDefaults.standard.set(image, forKey: "IMAGES")
            UserDefaults.standard.synchronize()
    }
    
    static var getImage: Data? {
            return UserDefaults.standard.data(forKey: "IMAGES")
        }
}
