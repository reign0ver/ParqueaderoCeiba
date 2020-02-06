//
//  EntranceVehicleService.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

enum AddExceptions: String, Error {
    case notFound = "The vehicle was not found in the parking"
}

class GetInVehicleService {
    
    let parkingDAO = ParkingDAOImpl()
    
    func getInVehicle (_ vehicle: Vehicle) throws -> Error? {
        //
        let vehicle = parkingDAO.findVehicle(vehicle.licencePlate)
        if vehicle != nil {
            throw AddExceptions.notFound
        }
        return nil
    }
    
    private func isParkingFullByVehicleType (_ type: String) {
        //
    }
    
    private func canVehicleGetInByLicencePlate (_ licenceName: String) {
        //
    }
    
}
