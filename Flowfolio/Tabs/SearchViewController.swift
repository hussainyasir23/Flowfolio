//
//  SearchViewController.swift
//  Flowfolio
//
//  Created by Yasir on 25/02/23.
//

import Foundation
import UIKit
import SafariServices

class SearchViewController: UIViewController {
    
    var searchText: String = "" {
        didSet {
            updateEditionsDataForSearch()
            searchTable.reloadData()
        }
    }
    
    var editionsData = DataManager.shared.getEditions()
    var playsData = DataManager.shared.playsData
    var editionsDataForSearch: [EditionData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("*** Debug: Search View Loaded ***")
        configureView()
        configureViewComponents()
        configureViewLayout()
        editionsDataForSearch = Array(editionsData?.suffix(5) ?? [])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.navigationItem.title = "Search"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureView() {
        view.backgroundColor = .black
        view.addSubview(searchTable)
        view.addSubview(searchBar)
    }
    
    func configureViewComponents() {
        
        searchBar.tintColor = .white
        searchBar.backgroundColor = .black
        searchBar.barTintColor = .white
        searchBar.placeholder = "Search Golazos here.."
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        
        searchTable.delegate = self
        searchTable.dataSource = self
        searchTable.isUserInteractionEnabled = true
        searchTable.separatorStyle = .none
        searchTable.backgroundColor = .black
        searchTable.register(MarketTableViewCell.self,
                             forCellReuseIdentifier: "MarketTableViewCell")
    }
    
    func configureViewLayout() {
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        searchTable.translatesAutoresizingMaskIntoConstraints = false
        searchTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        searchTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    lazy var searchTable: UITableView = {
        let searchTable = UITableView()
        searchTable.showsVerticalScrollIndicator = false
        return searchTable
    }()
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Golazos here.."
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    func updateEditionsDataForSearch() {
        if searchText == "" {
            editionsDataForSearch = Array(editionsData?.suffix(5) ?? [])
        }
        else {
            editionsDataForSearch = []
            editionsData?.forEach({
                let playID = $0.playID
                if let meta = playsData?.filter({$0.id == playID})[0].metadata {
                    if meta[PlayMetaData.PlayerKnownName.rawValue]!.hasPrefix(searchText) ||
                        meta[PlayMetaData.PlayerFirstName.rawValue]!.hasPrefix(searchText) ||
                        meta[PlayMetaData.PlayerLastName.rawValue]!.hasPrefix(searchText) {
                        editionsDataForSearch.append($0)
                    }
                }
            })
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editionsDataForSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketTableViewCell") as! MarketTableViewCell
        var editionsDataSource = editionsDataForSearch
        cell.editionData = editionsDataSource[indexPath.row]
        if let playsData = DataManager.shared.playsData {
            cell.playData = playsData.filter({$0.id == editionsDataSource[indexPath.row].playID})[0]
        }
        if let sereisData = DataManager.shared.seriesData {
            cell.seriesData = sereisData.filter({$0.id == editionsDataSource[indexPath.row].seriesID})[0]
        }
        if let playerData = DataManager.shared.playerData {
            cell.playerData = playerData[indexPath.row]
        }
        //cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        192
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = true
        let url = URL(string: "https://laligagolazos.com/editions/\(editionsDataForSearch[indexPath.row].id)")!
        let safariView = SFSafariViewController(url: url, configuration: config)
        safariView.view.backgroundColor = .black
        safariView.preferredBarTintColor = .black
        safariView.preferredControlTintColor = .white
        safariView.dismissButtonStyle = .close
        present(safariView, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else{
            return
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchText = searchBar.text ?? ""
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}
