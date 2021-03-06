//
//  ParkingViewModel.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 3/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class ParkingViewModel {
    
    // MARK: View Messages
    let cellId = "vehicleCell"
    let navigationTitle = "Vehicles"
    let emptyListMessage = "Parking is empty"
    
    private let model: ParkingModel
    
    var parkedVehicles: [Vehicle] = []
    var parkedVehiclesFiltered: [Vehicle] = []
    
    var message = ""
    
    init(parkingModel: ParkingModel) {
        self.model = parkingModel
    }
    
    func removeVehicleFromTheParking (_ vehicle: Vehicle) {
        model.removeVehicleFromTheParking(vehicle) { (response) in
            switch response {
            case .success(let data):
                self.message = data as! String
            case .failure(let error):
                self.message = error
            }
        }
    }
    
    func getAllVehicles () {
        parkedVehicles = model.getAllVehicles()
    }
    
    
}
