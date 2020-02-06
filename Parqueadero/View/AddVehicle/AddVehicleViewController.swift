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
        if let licenceName = licenceName.text, let type = type.text {
            let newVehicle = Vehicle(
                licencePlate: licenceName,
                type: type,
                cc: Int16(cc.text ?? "")!,
                date: Date()
            )
            viewModel.addVehicle(newVehicle)
        } else {
            //print all fields must be filled
        }
        
        //mover
        let alerta = UIAlertController(title: "Alert!", message: viewModel.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(ok)
        self.present(alerta, animated: true, completion: nil)
    }
    
}
