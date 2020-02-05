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
    lazy var vehicleTypes: Results<VehicleType> = {self.realm.objects(VehicleType.self)}()
    
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
                realm.add(vehicle)
            }
        } catch let error {
            print("Error while writing into Realm -> \(error.localizedDescription)")
        }
    }
    
    func getAllParkedVehicles () -> Results<Vehicle> {
        return realm.objects(Vehicle.self)
    }
    
    func removeFromParking (_ vehicle: Vehicle) {
        do {
            try realm.write {
                realm.delete(vehicle)
            }
        } catch let error {
            print("Error while removing from Realm -> \(error.localizedDescription)")
        }
    }
    
    func populateVehicleTypes () {
        if vehicleTypes.count == 0 {
            try! realm.write() {
                let defaultTypes = ["Car", "Motorcycle"]
                
                for type in defaultTypes {
                    let newType = VehicleType()
                    newType.typeName = type
                    realm.add(newType)
                }
            }
            vehicleTypes = realm.objects(VehicleType.self)
        }
    }
}
