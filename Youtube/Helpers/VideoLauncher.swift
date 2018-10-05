//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Manikandan V. Nair on 01/10/18.
//  Copyright © 2018 Manikandan V. Nair. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView
{
    let controllConatinerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let avi = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        avi.translatesAutoresizingMaskIntoConstraints = false
        avi.startAnimating()
        return avi
    }()
    
    lazy var playPauseButton: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        let image = UIImage(named: "pause")
        btn.setImage(image, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .white
        btn.isHidden = true
        btn.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return btn
    }()
    
    var isPlaying: Bool = true
    
    var avPlayer: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPalyerView()
        
        controllConatinerView.frame = frame
        addSubview(controllConatinerView)
        controllConatinerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controllConatinerView.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playPauseButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backgroundColor = .black
    }
    
    @objc func handlePause()
    {
        if isPlaying {
            avPlayer?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }else{
            avPlayer?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
 private  func setupPalyerView()  {
        let stringURL = "https://firebasestorage.googleapis.com/v0/b/kpsc-a58bc.appspot.com/o/DailyFeedsPhotos%2Fsample_video.mov?alt=media&token=6eeeeb24-339b-4e29-8bd1-4d6f7aa7eaab"
        if let url = URL(string: stringURL)
        {
            avPlayer = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: avPlayer)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            avPlayer?.play()
            avPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil) 
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges"
        {
            activityIndicatorView.stopAnimating()
            controllConatinerView.backgroundColor = .clear
            playPauseButton.isHidden = false
            isPlaying = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9/16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayer = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayer)
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (complete) in
                
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
    
}
