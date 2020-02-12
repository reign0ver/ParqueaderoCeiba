//
//  ParkingDAOImplTest.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 11/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class ParkingDAOImplTest: ParkingDAOProtocol {
    
    var vehicles: [Vehicle] = [
        Vehicle(licencePlate: "ANC717", type: "", cc: 0, date: Date())
    ]
    
    func insert (_ vehicle: Vehicle) {
        vehicles.append(vehicle)
    }
    
    func findVehicle (_ licenceName: String) -> Bool {
        let vehicleEntity = vehicles.filter{ $0.licencePlate == licenceName }
        if let _ = vehicleEntity.first {
            return true
        }
        return false
    }
    
    func getCountByVehicleType (_ type: String) -> Int {
        return type == Constants.car ? Constants.carLimit : Constants.motorcycleLimit
    }
    
    func getAllParkedVehicles() -> [Vehicle] {
        //Doesnt apply
        return vehicles
    }
    
    func removeFromParking(_ vehicle: Vehicle) {
        //Doesnt apply
    }
}
