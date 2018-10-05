//
//  ApiService.swift
//  Youtube
//
//  Created by Manikandan V. Nair on 26/09/18.
//  Copyright © 2018 Manikandan V. Nair. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    func fetchVideos(completion: @escaping ([Video]) -> ())  {
        
        
        fetchFeedFromUrlString(url: "\(baseURL)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingVideos(completion: @escaping ([Video]) -> ())  {
        
        fetchFeedFromUrlString(url: "\(baseURL)/trending.json", completion: completion)
        
    }
    
    func fetchSubscrptionVideos(completion: @escaping ([Video]) -> ())  {
        
        
        fetchFeedFromUrlString(url: "\(baseURL)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedFromUrlString(url: String, completion: @escaping ([Video]) -> ())
    {
        let url = URL(string: url   )
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if (error != nil)
            {
                print(error ?? "")
                return
            }
            do
            {
                if let unwrappedData = data, let jsonDataDics = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]]  {
                    
                    DispatchQueue.main.async {
                        completion(jsonDataDics.map({return Video(dictionary: $0)}))
                    }
                }
            }
            catch let error
            {
                print(error)
            }
            
            
            
            }.resume()
    }
}
