//
//  VehiclesViewController.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 3/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import UIKit

class VehiclesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ParkingViewModel()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        setupTableView()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getAllVehicles()
        tableView.reloadData()
    }
    
    private func setupNavbar () {
        self.navigationItem.title = viewModel.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddVehicle))
    }
    
    private func setupTableView () {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "VehicleCell", bundle: nil), forCellReuseIdentifier: viewModel.cellId)
    }
    
    private func setupSearchController () {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @objc private func goToAddVehicle () {
        let story = UIStoryboard(name: "AddVehicle", bundle: nil)
        let viewController = story.instantiateViewController(withIdentifier: "AddVehicleViewController") as! AddVehicleViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension VehiclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.parkedVehicles!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellId) as! VehicleCell
        let vehicle = !isFiltering ? viewModel.parkedVehicles![indexPath.row] : viewModel.parkedVehiclesFiltered![indexPath.row]
        cell.configureCell(vehicle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension VehiclesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedVehicle = viewModel.parkedVehicles![indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success) in
            let alert = UIAlertController(title: "You're going to delete a vehicle", message: "Are you sure you want to remove the vehicle from the parking?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                self.viewModel.removeVehicleFromTheParking(selectedVehicle)
                let alert = UIAlertController(title: "Total to pay!", message: "Your debt is \(self.viewModel.message)", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                self.present(alert, animated: true, completion: nil)
                alert.addAction(ok)
                tableView.reloadData()
            })
            let cancel = UIAlertAction(title: "CANCEL", style: .destructive, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = .red
        tableView.deselectRow(at: indexPath, animated: false)
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension VehiclesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let searchText = searchBar.text {
            filterResultsWithSearchString(searchText)
        }
    }
}
