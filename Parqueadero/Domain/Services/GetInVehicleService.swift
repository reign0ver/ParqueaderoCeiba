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
    case alreadyExists = "The vehicle you're trying to register is already in the park"
}

class GetInVehicleService {
    
    let parkingDAO = ParkingDAOImpl()
    
    func getInVehicle (_ vehicle: Vehicle) -> Response<Any> {
        if parkingDAO.findVehicle(vehicle.licencePlate) != nil {
            return Response(success: false, data: nil, error: GetInServiceErrors.alreadyExists.rawValue)
        }
        
        do {
            try isParkingFullByVehicleType(vehicle.type)
        } catch let error as GetInServiceErrors {
            print(error)
            return Response(success: false, data: nil, error: error.rawValue)
        } catch {
            print("Any other error ecurred", error.localizedDescription)
        }
        
        do {
            try canVehicleGetInToday(vehicle.licencePlate)
        } catch let error as GetInServiceErrors {
            print(error)
            return Response(success: false, data: nil, error: error.rawValue)
        } catch {
            print("Any other error ecurred", error.localizedDescription)
        }
        parkingDAO.insert(vehicle)
        return Response(success: true, data: Constants.addedVehicleSuccessfully, error: nil)
    }
    
    private func isParkingFullByVehicleType (_ type: String) throws {
        let count = parkingDAO.getCountByVehicleType(type: type)
        if (type.uppercased() == Constants.carVehicle && count == Constants.carLimit)
            || (type.uppercased() == Constants.motoVehicle && count == Constants.motorcycleLimit) {
            throw GetInServiceErrors.parkingIsFull
        }
    }
    
    private func canVehicleGetInToday (_ licenceName: String) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: Date())
        
        if licenceName.starts(with: Constants.licencePlateStartsWith)
            && (dayInWeek.uppercased() == Constants.sunday
                || dayInWeek.uppercased() == Constants.monday) {
            throw GetInServiceErrors.licencePlateNotAllowed
        }
    }
    
}
