//
//  Extensions.swift
//  FirebaseChats
//
//  Created by Satya on 10/20/17.
//  Copyright © 2017 Satya. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    func loadImageFromURL(urlString : String?){
        if let url_string = urlString {
            if let cachedImage = imageCache.object(forKey: url_string as AnyObject){
               self.image = cachedImage as? UIImage
            }
            else{
                let url = URL(string: url_string)
                URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                    if error == nil, let data = data{
                        DispatchQueue.main.async {
                            if let downloadedImage = UIImage(data: data){
                                imageCache.setObject(downloadedImage, forKey: url_string as AnyObject)
                                self.image = downloadedImage
                            }
                            
                        }
                    }
                }).resume()
            }
        }
    }
}
