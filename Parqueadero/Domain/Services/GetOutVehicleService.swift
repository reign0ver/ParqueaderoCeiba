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
    
    func calculatePayment (_ vehicle: Vehicle) -> Float {
        let calculatePaymentStrategy: CalculatePaymentProtocol = CalculatePaymentContext.getStrategy(type: vehicle.type)
        parkingDAO.removeFromParking(vehicle)
        return calculatePaymentStrategy.calculatePayment(vehicle)
    }
    
}
