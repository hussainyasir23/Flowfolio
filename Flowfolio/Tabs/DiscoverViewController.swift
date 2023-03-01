//
//  DiscoverViewController.swift
//  Flowfolio
//
//  Created by Yasir on 25/02/23.
//

import Foundation
import UIKit

class DiscoverViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("*** Debug: Discover View Loaded ***")
        configureView()
        configureViewComponents()
        configureViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.parent?.navigationItem.title = "Discover"
    }
    
    func configureView() {
        self.view.backgroundColor = .black
    }
    
    func configureViewComponents() {
        
    }
    
    func configureViewLayout() {
        
    }
}
