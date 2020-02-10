//
//  GetOutVehicleService.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class GetOutVehicleService {
    
    let parkingDAO = ParkingDAOImpl()
    
    func getOutVehicle (_ vehicle: Vehicle) -> Response<Any> {
        let totalToPay = calculatePayment(vehicle)
        let message = "You have to pay \(totalToPay)"
        return Response(success: true, data: message, error: nil)
    }
    
    func calculatePayment (_ vehicle: Vehicle) -> Double {
        let calculatePaymentStrategy: CalculatePaymentProtocol = CalculatePaymentContext.getStrategy(type: vehicle.type)
        parkingDAO.removeFromParking(vehicle)
        return calculatePaymentStrategy.calculatePayment(vehicle)
    }
    
}
