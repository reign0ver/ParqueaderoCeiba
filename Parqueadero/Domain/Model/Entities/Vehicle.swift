//
//  Vehicle.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class Vehicle {
    var id: Int
    var licencePlate: String
    
    init(id: Int, licencePlate: String) {
        self.id = id
        self.licencePlate = licencePlate
    }
}
