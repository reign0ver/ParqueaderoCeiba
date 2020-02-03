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
    
    let realm = try! Realm()
    lazy var vehicles: Results<Vehicle> = {self.realm.objects(Vehicle.self)}()
    lazy var vehicleTypes: Results<VehicleTypec> = {self.realm.objects(VehicleTypec.self)}()
    
    func insert (_ vehicle : Vehicle) {
        try! realm.write {
            realm.add(vehicle)
        }
    }
    
    func getAllParkedVehicles () {
        vehicles = realm.objects(Vehicle.self)
    }
    
    func removeFromParking (_ vehicle: Vehicle) {
        realm.delete(vehicle)
    }
    
    func populateVehicleTypes () {
        if vehicleTypes.count == 0 {
            try! realm.write() {
                let defaultTypes = ["Car", "Motorcycle"]
                
                for type in defaultTypes {
                    let newType = VehicleTypec()
                    newType.typeName = type
                    realm.add(newType)
                }
            }
            vehicleTypes = realm.objects(VehicleTypec.self)
        }
    }
}
