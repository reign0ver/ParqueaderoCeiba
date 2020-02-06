//
//  MapperProtocol.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 6/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

protocol MapperVehicleProtocol {
    static func mapIntoRealmEntities (_ vehicle: Vehicle) -> VehicleEntity
    static func mapIntoVehicle (_ vehicleEntity: VehicleEntity) -> Vehicle
    static func mapRealmListToArray (_ vehiclesEntityList: Results<VehicleEntity>) -> [Vehicle]
}
