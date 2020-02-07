//
//  EntranceVehicleService.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

enum GetInServiceErrors: String, Error {
    case parkingIsFull = "Parking is full :("
    case licencePlateNotAllowed = "You cannot get it :(.  Your licence plate is only allowed on Sunday and Monday"
}

class GetInVehicleService {
    
    let parkingDAO = ParkingDAOImpl()
    
    func getInVehicle (_ vehicle: Vehicle) throws ->  Error? {
        if let parkingFullError = try isParkingFullByVehicleType(vehicle.type) {
            return parkingFullError
        }
        if let licencePlateNotAllowed = try canVehicleGetInByLicencePlate(vehicle.licencePlate) {
            return licencePlateNotAllowed
        }
        parkingDAO.insert(vehicle)
        return nil
    }
    
    private func isParkingFullByVehicleType (_ type: String) throws ->  Error? {
        let count = parkingDAO.getCountByVehicleType(type: type)
        if (type == Constants.carVehicle && count == Constants.carLimit)
            || (type == Constants.motoVehicle && count == Constants.motorcycleLimit) {
            return GetInServiceErrors.parkingIsFull
        }
        return nil
    }
    
    private func canVehicleGetInByLicencePlate (_ licenceName: String) throws ->  Error? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: Date())
        
        if licenceName.starts(with: Constants.licencePlateStartsWith)
            && (dayInWeek.uppercased() == Constants.sunday
                || dayInWeek.uppercased() == Constants.monday) {
            return GetInServiceErrors.licencePlateNotAllowed
        }
        return nil
    }
    
}
