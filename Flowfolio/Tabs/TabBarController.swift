//
//  TabBarController.swift
//  Flowfolio
//
//  Created by Yasir on 25/02/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let marketplaceVC: MarketplaceViewController?
    let searchVC: SearchViewController?
    let portfolioVC: PortfolioViewController?
    let discoverVC: DiscoverViewController?
    let profileVC: ProfileViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("*** Debug: Tab bar View Loaded ***")
        configureView()
        configureViewComponents()
        configureViewLayout()
    }
    
    init(marketplaceVC: MarketplaceViewController?, searchVC: SearchViewController?, portfolioVC: PortfolioViewController?, discoverVC: DiscoverViewController?, profileVC: ProfileViewController?) {
        self.marketplaceVC = marketplaceVC
        self.searchVC = searchVC
        self.portfolioVC = portfolioVC
        self.discoverVC = discoverVC
        self.profileVC = profileVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureView() {
        self.delegate = self
        self.viewControllers = getViewControllers()
    }
    
    func configureViewComponents() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.backgroundColor = .black
        self.tabBar.backgroundImage = UIImage()
        
        let topBorder = CALayer();
        topBorder.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 0.4);
        topBorder.backgroundColor = UIColor.darkGray.cgColor
        self.tabBar.layer.addSublayer(topBorder)
        
        marketplaceVC?.tabBarItem = UITabBarItem(title: "Market", image: UIImage(named: "Marketplace"), tag: 0)
        searchVC?.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "Search"), tag: 1)
        portfolioVC?.tabBarItem = UITabBarItem(title: "Portfolio", image: UIImage(named: "Portfolio"), tag: 2)
        discoverVC?.tabBarItem = UITabBarItem(title: "Discover", image: UIImage(named: "Discover"), tag: 3)
        profileVC?.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "Profile"), tag: 4)
    }
    
    func configureViewLayout() {
        
    }
    
    func getViewControllers() -> [UIViewController] {
        return [marketplaceVC!, searchVC!, portfolioVC!, discoverVC!, profileVC!]
    }
}
