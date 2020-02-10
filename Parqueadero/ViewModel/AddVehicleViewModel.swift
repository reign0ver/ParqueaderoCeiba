//
//  AddVehicleViewModel.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 10/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class AddVehicleViewModel {
    
    //MARK: View Messages
    let newVehicleNavTitle = "New Vehicle"
    var message = ""
    
    private let model: ParkingModel
    
    init(parkingModel: ParkingModel) {
        self.model = parkingModel
    }
    
    func addVehicle (_ vehicle: Vehicle) {
        model.addVehicle(vehicle) { (response) in
            switch response {
            case .success(let data):
                self.message = data as! String
            case .failure(let error):
                self.message = error
            }
        }
    }
}
