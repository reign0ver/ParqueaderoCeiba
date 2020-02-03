//
//  AddVehicleViewController.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 3/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import UIKit

class AddVehicleViewController: UIViewController {
    
    
    var viewModel: ParkingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }
    
    private func setupNavbar () {
//        navigationItem.title = viewModel.userView?.name
        navigationItem.title = "New Vehicle"
    }

}
