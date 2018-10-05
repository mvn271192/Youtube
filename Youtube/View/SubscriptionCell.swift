//
//  SubscriptionCell.swift
//  Youtube
//
//  Created by Manikandan V. Nair on 27/09/18.
//  Copyright © 2018 Manikandan V. Nair. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchSubscrptionVideos { (videos) in
            
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
