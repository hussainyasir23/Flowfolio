//
//  WalletConnectViewController.swift
//  Flowfolio
//
//  Created by Yasir on 23/02/23.
//

import UIKit
import FCL

class WalletConnectViewController: UIViewController {
    
    var isUserLoggedIn: Bool = false {
        didSet {
            print("Debug: User Logged In")
        }
    }
    
    lazy var connectButton: UIButton = {
        let connectButton = UIButton()
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.setTitle("Connect Wallet", for: .normal)
        connectButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold, width: .standard)
        connectButton.layer.cornerRadius = 4
        connectButton.layer.cornerCurve = .continuous
        connectButton.sizeToFit()
        connectButton.addTarget(self, action: #selector(didTapConnect), for: .touchUpInside)
        return connectButton
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "Logo")
        return logoImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Debug: View Loaded")
        configureView()
        configureViewComponents()
        configureViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let _ = fcl.currentUser {
            print("User Authentication Successfull")
        }
        else {
            print("User Authentication Faiure")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.alpha = 1.0
    }
    
    func configureView() {
        view.addSubview(logoImageView)
        view.addSubview(connectButton)
    }
    
    func configureViewComponents() {
        setGradientBackground()
        
        connectButton.backgroundColor = #colorLiteral(red: 0.1079129651, green: 0.8437187672, blue: 0.3764159679, alpha: 1)
        connectButton.setTitleColor(.black, for: .normal)
        connectButton.titleLabel?.textAlignment = .center
    }
    
    func configureViewLayout() {
        
        logoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.50).isActive = true
        
        connectButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        connectButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor,  constant: view.bounds.height/4).isActive = true
        connectButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.60).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc func didTapConnect() {
        //view.alpha = 0.5
        print("Debug: Connect Tapped")
        fcl.openDiscovery()
    }
    
    
    
    func setGradientBackground() {
        let colorTop = #colorLiteral(red: 0.03900336474, green: 0.5773818493, blue: 0.858311832, alpha: 1).cgColor
        let colorBottom =  #colorLiteral(red: 0.002158528659, green: 0.8956373334, blue: 0.8458023071, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.5, y: 1.5)
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
