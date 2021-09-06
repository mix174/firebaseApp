//
//  ViewController.swift
//  firebaseApp
//
//  Created by Mix174 on 02.09.2021.
//

import UIKit
import FirebaseDatabase
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupVideo()
    }
    
    func setupView() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setupVideo() {
        guard let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4") else {
            print("bundlePath == nil")
            return
        }
        let url = URL(fileURLWithPath: bundlePath)
        
        let item = AVPlayerItem(url: url)
        
         videoPlayer = AVPlayer(playerItem: item)
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        
        guard let videoPlayerLayer = videoPlayerLayer else {
            print("videoPlayerLayer == nil")
            return
        }
        
        videoPlayerLayer.frame = CGRect(x: (-self.view.frame.size.width * 1.5),
                                        y: 0,
                                        width: (self.view.frame.size.width * 4),
                                        height: self.view.frame.size.height)
        
        view.layer.addSublayer(videoPlayerLayer)
        videoPlayer?.playImmediately(atRate: 0.4)
    }


    @IBAction func signUpTapped(_ sender: UIButton) {
    }
    
    @IBAction func loginTapped(_ sender: Any) {
    }
    
    
    
}

