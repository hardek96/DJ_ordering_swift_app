//
//  LocationViewController.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 09/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    @IBOutlet var tableView: UITableView!
    
    var filter = Filter.shared
    var cities = [City]()
    var filteredCities = [City]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        cities = [
            City(name:"Antony", country:"France"),
            City(name:"Lyon", country:"France"),
            City(name:"Palaiseau", country:"France"),
            City(name:"Paris 1er arrondissement", country:"France"),
            City(name:"Paris 2e arrondissement", country:"France"),
            City(name:"Paris 3e arrondissement", country:"France"),
            City(name:"Paris 4e arrondissement", country:"France"),
            City(name:"Paris 5e arrondissement", country:"France"),
            City(name:"Paris 6e arrondissement", country:"France"),
            City(name:"Paris 7e arrondissement", country:"France"),
            City(name:"Paris 8e arrondissement", country:"France"),
            City(name:"Paris 9e arrondissement", country:"France"),
            City(name:"Paris 10e arrondissement", country:"France"),
            City(name:"Paris 11e arrondissement", country:"France"),
            City(name:"Paris 12e arrondissement", country:"France"),
            City(name:"Paris 13e arrondissement", country:"France"),
            City(name:"Paris 14e arrondissement", country:"France"),
            City(name:"Paris 14e arrondissement", country:"France"),
            City(name:"Paris 15e arrondissement", country:"France"),
            City(name:"Paris 16e arrondissement", country:"France"),
            City(name:"Paris 17e arrondissement", country:"France"),
            City(name:"Paris 18e arrondissement", country:"France"),
            City(name:"Paris 19e arrondissement", country:"France"),
            City(name:"Paris 20e arrondissement", country:"France"),
        ]
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search City"
        definesPresentationContext = true
        tableView.tableHeaderView = self.searchController.searchBar
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredCities.count
        }
        
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let city: City
        if isFiltering() {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        cell.textLabel!.text = city.name
        cell.detailTextLabel!.text = city.country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city :City
        if isFiltering() {
            city = filteredCities[indexPath.row]
        } else {
            city = cities[indexPath.row]
        }
        
        filter.location = city.name
        dismiss(animated : true, completion : nil)
        dismiss(animated : true, completion : nil)
    }
    
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredCities = cities.filter({( city : City) -> Bool in
            return city.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}

extension LocationViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

