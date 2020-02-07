//
//  CalculatePaymentMotorcycle.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class CalculatePaymentMotorcycle: CalculatePaymentProtocol {
    
    func calculatePayment(_ vehicle: Vehicle) -> Double {
        let (days, hours) = CalculateTimeService.calculateTime(vehicle: vehicle)
        var totalToPay = (MotorcyclePrices.day.rawValue * Double(days)) + (MotorcyclePrices.hour.rawValue * Double(hours))
        if vehicle.cc >= 500 {
            totalToPay += MotorcyclePrices.extraCC.rawValue
        }
        return totalToPay
    }
}
