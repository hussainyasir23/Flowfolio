//
//  MarketplaceViewController.swift
//  Flowfolio
//
//  Created by Yasir on 25/02/23.
//

import Foundation
import UIKit
import SafariServices

class MarketplaceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("*** Debug: Market place View Loaded ***")
        configureView()
        configureViewComponents()
        configureViewLayout()
    }
    
    lazy var marketTable: UITableView = {
        let marketTable = UITableView()
        
        return marketTable
    }()
    
    private let refreshControl = UIRefreshControl()
    
    func configureView() {
        view.addSubview(marketTable)
    }
    
    func configureViewComponents() {
        
        view.backgroundColor = .black
        
        marketTable.delegate = self
        marketTable.dataSource = self
        marketTable.isUserInteractionEnabled = true
        marketTable.separatorStyle = .none
        marketTable.backgroundColor = .black
        marketTable.register(MarketTableViewCell.self,
                             forCellReuseIdentifier: "MarketTableViewCell")
        if #available(iOS 10.0, *) {
            marketTable.refreshControl = refreshControl
        } else {
            marketTable.addSubview(refreshControl)
        }
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshMarketData(_:)), for: .valueChanged)
    }
    
    func configureViewLayout() {
        
        marketTable.translatesAutoresizingMaskIntoConstraints = false
        marketTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        marketTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        marketTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        marketTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func refreshMarketData(_ sender: Any) {
        marketTable.reloadData()
        self.refreshControl.endRefreshing()
    }
}

extension MarketplaceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let editionsData = DataManager.shared.editionsData {
            return editionsData.count - 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell") as! MarketTableViewCell
        if let editionsData = DataManager.shared.editionsData?.sorted(by: {$0.id < $1.id}) {
            cell.editionData = editionsData[indexPath.row]
            if let playsData = DataManager.shared.playsData {
                cell.playData = playsData.filter({$0.id == editionsData[indexPath.row].playID})[0]
            }
            if let playDataId = DataManager.shared.playDataIds[editionsData[indexPath.row].playID] {
                cell.playDataId = playDataId
            }
            if let sereisData = DataManager.shared.seriesData {
                cell.seriesData = sereisData.filter({$0.id == editionsData[indexPath.row].seriesID})[0]
            }
        }
        //cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = true
        
        let url = URL(string: "https://laligagolazos.com/editions/\(indexPath.row + 1)")!
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
}
