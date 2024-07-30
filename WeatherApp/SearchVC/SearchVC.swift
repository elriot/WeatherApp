//
//  SearchVC.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-29.
//

import UIKit

protocol SearchVCDelegate where Self: HomeVC {
    func didSelect(_ location: SearchLocation)
}

class SearchVC: UIViewController {
    static let id = "SearchVC"
    weak var delegate: SearchVCDelegate?
    private let lm = LocationsManager.shared
    
    private lazy var search: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultVC())
        search.searchBar.placeholder = "Search by city"
        search.obscuresBackgroundDuringPresentation = true
        search.hidesNavigationBarDuringPresentation = false
        search.searchResultsUpdater = self
        return search
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        setupUI()
        setupTableView()
    }
    
    private func setupUI(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationRow.self, forCellReuseIdentifier: LocationRow.searchId)
    }
}

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lm.getLocations().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.searchId) as! LocationRow
        let locations = lm.getLocations()
        let location = locations[indexPath.row]
        cell.configure(location)
        return cell
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // delete function (SearchLocation)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let locations = lm.getLocations()
            let location = locations[indexPath.row]
            lm.delete(location)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let locations = lm.getLocations()
        let location = locations[indexPath.row]
        delegate?.didSelect(location)
        popVC()
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
             return
        }
        
        // optional casting
//        guard let searchResults = searchController.searchResultsController as? SearchResultVC else { return }
        
        // force casting
        let searchResults = searchController.searchResultsController as! SearchResultVC
        searchResults.update(text: text)
        searchResults.delegate = self
    }
}

extension SearchVC: SearchResultsVCDelegate {
    func didSelect(_ location: SearchLocation) {
        lm.appendAndSave(location)
        let locations = lm.getLocations()
        
        tableView.beginUpdates()
        let index = IndexPath(row: locations.count-1, section: 0)
        tableView.insertRows(at: [index], with: .automatic)
        tableView.endUpdates()
        search.isActive = false
//        print("Here we are", location.name, location.lat, location.lon)
    }
}
