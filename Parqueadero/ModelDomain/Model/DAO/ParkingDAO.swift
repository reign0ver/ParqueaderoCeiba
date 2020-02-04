//
//  ParkingDAO.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 31/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class ParkingDAO {
    
    var realm = try! Realm()
//    lazy var vehicles: Results<Vehicle> = {self.realm.objects(Vehicle.self)}()
    lazy var vehicleTypes: Results<VehicleType> = {self.realm.objects(VehicleType.self)}()
    
//    init() {
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//    }
    
    func insert (_ vehicle : Vehicle) {
        try! realm.write {
            realm.add(vehicle)
        }
    }
    
    func getAllParkedVehicles () -> Results<Vehicle> {
        return realm.objects(Vehicle.self)
    }
    
    func removeFromParking (_ vehicle: Vehicle) {
        try! realm.write {
            realm.delete(vehicle)
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
