//
//  Parqueadero.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class ParkingService {
    
    let parkingDAO: ParkingDAOImpl = ParkingDAOImpl()
    
    let getInVehicleService = GetInVehicleService()
    let getOutVehicleService = GetOutVehicleService()
    
    func getInToTheParking (vehicle: Vehicle) -> Response<Any> {
        if let error = try! getInVehicleService.getInVehicle(vehicle) {
            return Response(success: false, data: nil, error: error.localizedDescription)
        }
        return Response(success: true, data: Constants.addedVehicleSuccessfully, error: nil)
    }
    
    func getOutFromTheParking (vehicle: Vehicle) -> Response<Any> {
        let totalToPay = getOutVehicleService.calculatePayment(vehicle)
        return Response(success: true, data: totalToPay, error: nil)
    }
    
    func getAllParkedVehicles () -> [Vehicle] {
        return parkingDAO.getAllParkedVehicles()
    }
}
