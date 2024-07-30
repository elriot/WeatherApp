//
//  SearchResultVC.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-29.
//

import UIKit

protocol SearchResultsVCDelegate where Self: SearchVC {
    func didSelect(_ location: SearchLocation)
}

class SearchResultVC: UIViewController {

    weak var delegate: SearchResultsVCDelegate?
    private var locations : [SearchLocation] = []
    
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
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationRow.self, forCellReuseIdentifier: LocationRow.resultsId)
    }
    
    func update(text: String){
        print(text)
        Api.shared.fetchSample([SearchLocation].self) { [weak self] locations in
            guard let self, let locations else { return }
            self.locations = locations
            self.tableView.reloadData()
        }
    }
}

extension SearchResultVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationRow.resultsId) as! LocationRow
        let location = locations[indexPath.row]
        cell.configure(location)
        return cell
    }
}

extension SearchResultVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let location = locations[indexPath.row]
        delegate?.didSelect(location)
    }
}
