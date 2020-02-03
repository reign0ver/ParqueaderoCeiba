//
//  ParkingViewModel.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 3/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class ParkingViewModel {
    
    // MARK: View Messages
    let cellId = "vehicleCell"
    let navigationTitle = "Vehicles"
    let emptyListMessage = "Parking is empty"
    
    let model = ParkingController()
    
    
    let v1 = Vehicle()
    let v2 = Vehicle()
    
    var parkedVehicles: [Vehicle] = []
    var parkedVehiclesFiltered: [Vehicle] = []
    
    init() {
        v1.licencePlate = "ABC 000"
        v2.licencePlate = "DEF 111"
        parkedVehicles = [v1, v2]
    }
}
