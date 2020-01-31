//
//  Vehicle.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

@objc enum VehicleType: Int8 {
    case car = 0
    case motorcycle = 1
}

class Vehicle: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var licencePlate: String = ""
    @objc dynamic var type: VehicleType
    @objc dynamic var cc: Int16 = 0
    @objc dynamic var date: Date = Date()
    
    init(id: Int, licencePlate: String, date: Date, type: VehicleType) {
        self.id = id
        self.licencePlate = licencePlate
        self.date = date
        self.type = type
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
}
