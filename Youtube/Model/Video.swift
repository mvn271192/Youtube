//
//  Video.swift
//  Youtube
//
//  Created by Manikandan V. Nair on 15/09/18.
//  Copyright © 2018 Manikandan V. Nair. All rights reserved.
//

import UIKit

class JsonSafeObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        
        let uppercaseFirstChar = String(key.first!).uppercased()
        let range = key.startIndex...key.index(key.startIndex, offsetBy: 0)
        let selectorString = key.replacingCharacters(in: range, with: uppercaseFirstChar)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        if (!responds)
        {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

@objcMembers
class Video: JsonSafeObject
{
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var dateUploaded: NSDate?
    var channel: Channel?
    var duration: NSNumber?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        
        if (key == "channel")
        {
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [ String: AnyObject])
        }
        else{
            super.setValue(value, forKey: key)
        }
        
    }
}

@objcMembers
class Channel: JsonSafeObject
{
    var name: String?
    var profile_image_name: String?
}
