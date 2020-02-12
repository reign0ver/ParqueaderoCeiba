//
//  ListVehicles.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 10/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class ListVehiclesService {
    
    var parkingDAO: ParkingDAOProtocol
    
    init(parkingDAO: ParkingDAOProtocol) {
        self.parkingDAO = parkingDAO
    }
    
    func getAllParkedVehicles () -> [Vehicle] {
        return parkingDAO.getAllParkedVehicles()
    }
}
