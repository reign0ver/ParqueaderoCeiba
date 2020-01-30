//
//  Motorcycle.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class Motorcycle: Vehicle {
    var cc: Int16 = 0
    
    init(id: Int, licencePlate: String, cc: Int16) {
        self.cc = cc
        super.init(id: id, licencePlate: licencePlate)
    }
}
