//
//  VehiclesViewControllerHelper.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 3/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

extension VehiclesViewController {
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterResultsWithSearchString(_ searchText: String) {
        viewModel!.parkedVehiclesFiltered = viewModel!.parkedVehicles.filter {
            return $0.licencePlate.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
