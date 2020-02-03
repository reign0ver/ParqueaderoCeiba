//
//  MainViewController.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 3/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import UIKit

class VehiclesViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupNavbar () {
        self.navigationItem.title = viewModel.navigationTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
