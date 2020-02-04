//
//  Vehicle.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class Vehicle: Object {
    @objc dynamic var licencePlate: String = ""
    @objc dynamic var type: VehicleType!
    @objc dynamic var cc: Int16 = 0
    @objc dynamic var date: Date = Date()
}
