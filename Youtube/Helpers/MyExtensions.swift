//
//  MyExtensions.swift
//  Youtube
//
//  Created by Manikandan V. Nair on 14/09/18.
//  Copyright © 2018 Manikandan V. Nair. All rights reserved.
//

import UIKit

extension UIColor
{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...)
    {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated()
        {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView
{
    var imageUrlString: String?
    func loadImageWithUrlString(urlString: String)
    {
        image = nil
        imageUrlString = urlString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage
        {
            self.image = imageFromCache
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if (error != nil)
            {
                print(error ?? "")
                return
            }
            if  let image = UIImage(data: data!)
            {
                DispatchQueue.main.async {
                    if self.imageUrlString == urlString
                    {
                        self.image = image
                    }
                    
                    let imageToCache = UIImage(data: data!)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    
                }
                
            }
            
            }.resume()
    }
}



