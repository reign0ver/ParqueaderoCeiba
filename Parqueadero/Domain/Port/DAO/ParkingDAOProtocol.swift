//
//  IParkingDAO.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

protocol ParkingDAOProtocol {
    func insert (_ vehicle: Vehicle)
    func getAllParkedVehicles () -> [Vehicle]
    func removeFromParking (_ vehicle: Vehicle)
    func findVehicle (_ licenceName: String) -> Bool
    func getCountByVehicleType (_ type: String) -> Int
}
