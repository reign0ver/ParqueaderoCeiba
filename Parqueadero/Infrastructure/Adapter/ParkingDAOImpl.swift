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
//    lazy var vehicleTypes: Results<VehicleType> = {self.realm.objects(VehicleType.self)}()
    
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
    
    func getAllParkedVehicles () -> [Vehicle] {
        return MapperVehicleImpl.mapRealmListToArray(realm.objects(VehicleEntity.self))
    }
    
    func findVehicle (_ licenceName: String) -> Vehicle? {
        let vehicleEntity = realm.objects(VehicleEntity.self).filter("licencePlate contains \(licenceName)")
        if let vEntity = vehicleEntity.first {
            return MapperVehicleImpl.mapIntoVehicle(vEntity)
        }
        return nil
    }
    
    func removeFromParking (_ vehicle: Vehicle) {
        do {
            try realm.write {
                realm.delete(MapperVehicleImpl.mapIntoRealmEntities(vehicle))
            }
        } catch let error {
            print("Error while removing from Realm -> \(error.localizedDescription)")
        }
    }
    
    //se implementa? o mejor como constantes?
    
//    func populateVehicleTypes () {
//        if vehicleTypes.count == 0 {
//            try! realm.write() {
//                let defaultTypes = ["Car", "Motorcycle"]
//
//                for type in defaultTypes {
//                    let newType = VehicleType()
//                    newType.typeName = type
//                    realm.add(newType)
//                }
//            }
//            vehicleTypes = realm.objects(VehicleType.self)
//        }
//    }
}
