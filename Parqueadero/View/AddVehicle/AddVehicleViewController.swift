//
//  AddVehicleViewController.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 3/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import UIKit

class AddVehicleViewController: UIViewController {
    
    @IBOutlet weak var licenceName: UITextField!
    @IBOutlet weak var cc: UITextField!
    @IBOutlet weak var type: UITextField!
    
    let viewModel = ParkingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
    }
    
    private func setupNavbar () {
        navigationItem.title = viewModel.newVehicleNavTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
    }
    
    @objc private func save () {
        let vehicleType = VehicleType()
        vehicleType.typeName = type.text!
        let newVehicle = Vehicle()
        newVehicle.licencePlate = licenceName.text!
        newVehicle.cc = Int16(cc.text!) ?? 0
        newVehicle.type = vehicleType
        
        viewModel.addVehicle(newVehicle)
        
        let alerta = UIAlertController(title: "Alert!", message: viewModel.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(ok)
        self.present(alerta, animated: true, completion: nil)
    }
    
}
