//
//  Parqueadero.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class ParqueaderoController {
    
    var vehicles: [Vehicle] = []
    
    func addVehicleToThePark () {
        
    }
    
    func removeVehicleInThePark () {
        
    }
    
    func findVehicleIntoThePark (licencePlate: String) -> Vehicle {
        return Vehicle(id: 0, licencePlate: "")
    }
    
    func calculatePay (vehicle: Vehicle) -> Float {
        return 0.0
    }
}
