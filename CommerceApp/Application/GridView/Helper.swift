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
}
