//
//  CalculatePaymentContext.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class CalculatePaymentContext {
    
    static func getStrategy (_ vehicle: Vehicle) -> CalculatePaymentProtocol {
        return vehicle.type.typeName == "Car" ? CalculatePaymentCar() : CalculatePaymentMotorcycle()
    }
    
}
