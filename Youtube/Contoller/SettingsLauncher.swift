//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Manikandan V. Nair on 17/09/18.
//  Copyright © 2018 Manikandan V. Nair. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
     init(name: SettingName, imageName: String) {
        
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case Privacy = "Terms & privacy policy"
    case Feedback = "Send feedback"
    case Help = "Help"
    case SwitchAccount = "Switch account"
}

class SettingsLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let blackView = UIView()
    let collectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
        
    }()
    
    var homeController: HomeController?
    
    let cellId = "CellId"
    let cellHeight: CGFloat = 50.0
    let settingsArray:[Setting] = {
       
        return [Setting(name: .Settings, imageName: "settings"),
                Setting(name: .Privacy, imageName: "privacy"),
                Setting(name: .Feedback, imageName: "feedback"),
                Setting(name: .Help, imageName: "help"),
                Setting(name: .SwitchAccount, imageName: "customer"),
                Setting(name: .Cancel, imageName: "cancel")]
    }()
    
    func showSettings()
    {
        if let window = UIApplication.shared.keyWindow
        {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.alpha = 0
            blackView.frame = window.frame
            blackView.isUserInteractionEnabled = true
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            let height:CGFloat = CGFloat(settingsArray.count) * cellHeight
            let y = window.frame.height - height
            window.addSubview(collectionView)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.frame.height, height: height)
                
            }, completion: nil)
            
        }
        
    }
    
    @objc func handleDismiss()
    {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow
            {
                self.collectionView.frame  = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
            }
        }
    }
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        let setting = settingsArray[indexPath.row]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow
            {
                self.collectionView.frame  = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 0)
            }
        }) { (completed) in
            let setting = self.settingsArray[indexPath.row]
            if (setting.name != .Cancel)
            {
                self.homeController?.showControllerForSetting(setting: setting)
            }
            
        }
    }
}
