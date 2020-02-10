//
//  ParkingDAO.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 31/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class ParkingDAOImpl: ParkingDAOProtocol {
    
    var realm: Realm!
    
    init() {
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        do {
            realm = try Realm()
        } catch let error {
            print("Error while initializing Realm -> \(error.localizedDescription)")
        }
    }
    
    func insert (_ vehicle: Vehicle) {
        do {
            try realm.write {
                realm.add(MapperVehicleImpl.mapIntoRealmEntities(vehicle))
            }
        } catch let error {
            print("Error while writing into Realm -> \(error.localizedDescription)")
        }
    }
    
    func removeFromParking (_ vehicle: Vehicle) {
        let vehicleEntity = realm.objects(VehicleEntity.self).filter("licencePlate == '\(vehicle.licencePlate)'")
        if let vEntity = vehicleEntity.first {
            do {
                try realm.write {
                    realm.delete(vEntity)
                }
            } catch let error {
                print("Error while removing from Realm -> \(error.localizedDescription)")
            }
        }
    }
    
    func findVehicle (_ licenceName: String) -> VehicleEntity? {
        let vehicleEntity = realm.objects(VehicleEntity.self).filter("licencePlate == '\(licenceName)'")
        if let vEntity = vehicleEntity.first {
            return vEntity
        }
        return nil
    }
    
    func getAllParkedVehicles () -> [Vehicle] {
        return MapperVehicleImpl.mapRealmListToArray(realm.objects(VehicleEntity.self))
    }
    
    func getCountByVehicleType (type: String) -> Int {
        let vehicleType = realm.objects(VehicleEntity.self).filter("type = '\(type)'")
        return vehicleType.count
    }
}
