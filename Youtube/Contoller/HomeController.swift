//
//  ViewController.swift
//  Youtube
//
//  Created by Manikandan V. Nair on 13/09/18.
//  Copyright © 2018 Manikandan V. Nair. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "CellId"
    let TrendingCellId = "TrendingCellId"
    let SubscriptionCellId = "SubscriptionCellId"
    
    let titles = ["Home", "Trending", "Subscreptions", "Account"]
    lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.homeController = self
        return menu
    }()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "   Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        
        setupCollectionViews()
        setupMenuBar()
        
    }
    
    func setupCollectionViews()
    {
        if let flowlayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        {
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = .white
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "CellId")
        //collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCellId)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: SubscriptionCellId)
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.isPagingEnabled = true
    }
    
    
  
    
    func setupNavButtons()  {
        
        let searchBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchBtnClick))
        let navBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "navMenu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navBtnClick))
        
        self.navigationItem.rightBarButtonItems = [navBtn, searchBtn]
    }
    
    func setupMenuBar()  {
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor =  UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        view.addSubview(redView)
        view.addSubview(menuBar)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]|", views: redView)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func searchBtnClick()
    {
       
    }
    
    @objc func navBtnClick()
    {
       settingsLauncher.showSettings()
       
    }
    
    func scrollToMenuIndex(menuIndex: Int)
    {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setTitleFromIndex(index: menuIndex)
    }
    
    private func setTitleFromIndex(index: Int)
    {
        if let titleLabel = navigationItem.titleView as? UILabel
        {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    func  showControllerForSetting(setting: Setting)
    {
        let settingController = UIViewController()
        settingController.view.backgroundColor = UIColor.white
        settingController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.pushViewController(settingController, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = false
        navigationController!.navigationBar.barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        //remove line
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        setupNavButtons()
        
    }
  
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        setTitleFromIndex(index: index)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier: String
        
        if indexPath.item == 1 {
            cellIdentifier = TrendingCellId
        }
        else if indexPath.item == 2 {
            cellIdentifier = SubscriptionCellId
        }
        else
        {
            cellIdentifier = cellId
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    

}






