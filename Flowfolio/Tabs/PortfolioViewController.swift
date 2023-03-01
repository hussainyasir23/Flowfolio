//
//  PortfolioViewController.swift
//  Flowfolio
//
//  Created by Yasir on 25/02/23.
//

import Foundation
import UIKit
import FCL

class PortfolioViewController: UIViewController {
    
    var isInit: Bool = false {
        didSet {
            if isInit {
                print("*** Debug: User Init Successful ***")
                showPortfolio()
                self.parent?.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "LogOutIcon.png")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(logout))]
            }
            else {
                print("*** Debug: User Init Failed ***")
                configureView()
                configureViewLayout()
                self.parent?.navigationItem.rightBarButtonItems = []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureViewComponents()
        configureViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.parent?.navigationItem.title = "Portfolio"
        check()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureView() {
        view.addSubview(logoImageView)
        view.addSubview(connectButton)
    }
    
    func configureViewComponents() {
        //setGradientBackground()
        view.backgroundColor = .black
        
        connectButton.backgroundColor = .white//#colorLiteral(red: 0.1079129651, green: 0.8437187672, blue: 0.3764159679, alpha: 1)
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
    
    lazy var connectButton: UIButton = {
        let connectButton = UIButton()
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.setTitle("Connect Wallet", for: .normal)
        connectButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        connectButton.layer.cornerRadius = 8.0
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
    
    lazy var connectionLabel: UILabel = {
        let connectionLabel = UILabel()
        connectionLabel.text = "Wallet Connection Successful"
        connectionLabel.textColor = .lightGray
        connectionLabel.font = .systemFont(ofSize: 15)
        return connectionLabel
    }()
    
    lazy var addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.text = "Wallet Address: "
        addressLabel.textColor = .lightGray
        addressLabel.font = .systemFont(ofSize: 15)
        return addressLabel
    }()
    
    lazy var walletAddressLabel: UILabel = {
        let walletAddressLabel = UILabel()
        walletAddressLabel.textColor = .white
        walletAddressLabel.font = .systemFont(ofSize: 15)
        return walletAddressLabel
    }()
    
    lazy var nothingLabel: UILabel = {
        let nothingLabel = UILabel()
        nothingLabel.textColor = .white
        nothingLabel.textAlignment = .center
        nothingLabel.text = "Nothing to show.\nYou do not hold any Golazos."
        nothingLabel.numberOfLines = 0
        return nothingLabel
    }()
    
    lazy var marketButton: UIButton = {
        let marketButton = UIButton()
        marketButton.backgroundColor = .white
        marketButton.setTitleColor(.black, for: .normal)
        marketButton.titleLabel?.textAlignment = .center
        marketButton.setTitle("Checkout Marketplace", for: .normal)
        marketButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        marketButton.layer.cornerRadius = 8.0
        marketButton.layer.cornerCurve = .continuous
        marketButton.sizeToFit()
        marketButton.addTarget(self, action: #selector(didTapMarket), for: .touchUpInside)
        return marketButton
    }()
    
    @objc func didTapConnect() {
        fcl.openDiscovery()
        DataManager.shared.invoke()
    }
    
    @objc func didTapMarket() {
        
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
    
    func check() {
        Task {
            do {
                isInit = try await FlowManager.shared.checkCollectionVault()
            } catch {
                print(error)
            }
        }
    }
    
    @objc func logout(){
        
    }
    
    func showPortfolio() {
        connectButton.removeFromSuperview()
        logoImageView.removeFromSuperview()
        walletAddressLabel.text = fcl.currentUser?.addr.hex
        
        view.addSubview(connectionLabel)
        view.addSubview(addressLabel)
        view.addSubview(walletAddressLabel)
        view.addSubview(nothingLabel)
        view.addSubview(marketButton)
        
        connectionLabel.translatesAutoresizingMaskIntoConstraints = false
        connectionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        connectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        addressLabel.topAnchor.constraint(equalTo: connectionLabel.bottomAnchor, constant: 4).isActive = true
        
        walletAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        walletAddressLabel.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 4).isActive = true
        walletAddressLabel.topAnchor.constraint(equalTo: addressLabel.topAnchor).isActive = true
        
        nothingLabel.translatesAutoresizingMaskIntoConstraints = false
        nothingLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        nothingLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        marketButton.translatesAutoresizingMaskIntoConstraints = false
        marketButton.topAnchor.constraint(equalTo: nothingLabel.bottomAnchor, constant: 8).isActive = true
        marketButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        marketButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75).isActive = true
        marketButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
