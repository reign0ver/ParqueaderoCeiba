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
    let newVehicleNavTitle = "New Vehicle"
    let emptyListMessage = "Parking is empty"
    
    let model = ParkingController()
    
    var parkedVehicles: Results<Vehicle>?
    var parkedVehiclesFiltered: Results<Vehicle>?
    
    var message = ""
    
    func addVehicle (_ vehicle: Vehicle) {
        message = model.addVehicleToTheParking(vehicle: vehicle)
    }
    
    func removeVehicleFromTheParking (_ vehicle: Vehicle) {
//        model.removeVehicleInTheParking(vehicle)
        let totalToPay = model.calculatePay(vehicle: vehicle)
        message = "Total to pay: \(totalToPay)"
    }
    
    func getAllVehicles () {
        parkedVehicles = model.getAllParkedVehicles()
    }
    
    
}
