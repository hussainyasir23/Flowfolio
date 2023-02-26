//
//  SplashAnimationViewController.swift
//  Flowfolio
//
//  Created by Yasir on 24/02/23.
//

import Foundation
import AVKit

class SplashAnimationViewController: UIViewController {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        loadAnimationAsset()
    }
    
    private func loadAnimationAsset() {
        
        guard let path = Bundle.main.path(forResource: "flowFolioAnimation", ofType:"mp4") else {
            debugPrint("flowFolioAnimation.mp4 not found")
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        player?.seek(to: CMTime.zero)
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = view.bounds
        playerLayer?.videoGravity = .resizeAspect
        playerLayer?.zPosition = -1
        
        view.layer.addSublayer(playerLayer!)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(animationFinished),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(resumeAnimation),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pauseAnimation),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        player?.play()
        player?.rate = 1.25
    }
    
    @objc func resumeAnimation() {
        player?.play()
        player?.rate = 1.25
    }
    
    @objc func pauseAnimation() {
        player?.pause()
    }
    
    @objc func animationFinished() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = UINavigationController(rootViewController: TabBarController(
            marketplaceVC: MarketplaceViewController(),
            searchVC: SearchViewController(),
            portfolioVC: PortfolioViewController(),
            discoverVC: DiscoverViewController(),
            profileVC: ProfileViewController()))
        appDelegate.window?.makeKeyAndVisible()
    }
}
