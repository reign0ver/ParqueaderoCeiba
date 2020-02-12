//
//  EntranceVehicleService.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class GetInVehicleService {
    
    var parkingDAO: ParkingDAOProtocol
    
    init(parkingDAO: ParkingDAOProtocol) {
        self.parkingDAO = parkingDAO
    }
    
    func getInVehicle (_ vehicle: Vehicle) -> Response<Any> {
        do {
            try alreadyExistInThePark(vehicle.licencePlate)
        } catch let error as GetInServiceErrors {
            return Response(success: false, data: nil, error: error.rawValue)
        } catch {
            print("Any other error ecurred", error.localizedDescription)
        }
        
        do {
            try isParkingFullByVehicleType(vehicle.type)
        } catch let error as GetInServiceErrors {
            return Response(success: false, data: nil, error: error.rawValue)
        } catch {
            print("Any other error ecurred", error.localizedDescription)
        }
        
        do {
            try canVehicleGetInToday(vehicle.licencePlate)
        } catch let error as GetInServiceErrors {
            return Response(success: false, data: nil, error: error.rawValue)
        } catch {
            print("Any other error ecurred", error.localizedDescription)
        }
        parkingDAO.insert(vehicle)
        return Response(success: true, data: Constants.addedVehicleSuccessfully, error: nil)
    }
    
    func alreadyExistInThePark (_ licencePlate: String) throws {
        let exist = parkingDAO.findVehicle(licencePlate)
        if exist {
            throw GetInServiceErrors.alreadyExists
        }
    }
    
    func isParkingFullByVehicleType (_ type: String) throws {
        let count = parkingDAO.getCountByVehicleType(type)
        if (type.uppercased() == Constants.car && count == Constants.carLimit)
            || (type.uppercased() == Constants.moto && count == Constants.motorcycleLimit) {
            throw GetInServiceErrors.parkingIsFull
        }
    }
    
    func canVehicleGetInToday (_ licenceName: String) throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: Date())
        
        if licenceName.starts(with: Constants.licencePlateStartsWith)
            && (dayInWeek.uppercased() != Constants.sunday
                || dayInWeek.uppercased() != Constants.monday) {
            throw GetInServiceErrors.licencePlateNotAllowed
        }
    }
    
}
