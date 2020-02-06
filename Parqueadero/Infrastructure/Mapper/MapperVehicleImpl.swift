//
//  MapperVehicleImpl.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 6/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class MapperVehicleImpl: MapperVehicleProtocol {
    
    static func mapIntoRealmEntities(_ vehicle: Vehicle) -> VehicleEntity {
        let vehicleEntity = VehicleEntity()
        vehicleEntity.licencePlate = vehicle.licencePlate
        vehicleEntity.type = vehicle.type
        vehicleEntity.cc = vehicle.cc
        vehicleEntity.date = vehicle.date
        
        return vehicleEntity
    }
    
    static func mapIntoVehicle(_ vehicleEntity: VehicleEntity) -> Vehicle {
        let vehicle = Vehicle(
            licencePlate: vehicleEntity.licencePlate,
            type: vehicleEntity.type,
            cc: vehicleEntity.cc,
            date: vehicleEntity.date
        )
        return vehicle
    }
    
    static func mapRealmListToArray(_ vehiclesEntityList: Results<VehicleEntity>) -> [Vehicle] {
        var vehicleList: [Vehicle] = []
        for vEntity in vehiclesEntityList {
            vehicleList.append(mapIntoVehicle(vEntity))
        }
        return vehicleList
    }
}
