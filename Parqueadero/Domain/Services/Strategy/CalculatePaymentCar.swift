//
//  CalculatePaymentCar.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class CalculatePaymentCar: CalculatePaymentProtocol {
    
    func calculatePayment(_ vehicle: Vehicle) -> Double {
        let (days, hours) = CalculateTimeService.calculateTime(vehicle: vehicle)
        return (CarPrices.day.rawValue * Double(days)) + (CarPrices.hour.rawValue * Double(hours))
    }
}
