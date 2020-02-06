//
//  VehicleEntity.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 6/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class VehicleEntity: Object {
    @objc dynamic var licencePlate: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var cc: Int16 = 0
    @objc dynamic var date: Date = Date()
}
