//
//  ParkingModel.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 5/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

enum ModelResponse <T> {
    case success (result: T)
    case failure (error: String)
}

typealias ModelCompletion = ( (_ response: ModelResponse<Any>) -> Void )

class ParkingModel {
    
    let parkingController = ParkingService()
    
    func addVehicle (_ vehicle: Vehicle, completion: @escaping ModelCompletion) {
        let response = parkingController.addVehicleToTheParking(vehicle: vehicle)
        if response.status {
            completion(.success(result: response.data))
        } else {
            completion(.failure(error: response.error))
        }
    }
    
    func removeVehicleFromTheParking (_ vehicle: Vehicle, completion: @escaping ModelCompletion) {
        let response = parkingController.calculatePay(vehicle: vehicle)
        if response.status {
            completion(.success(result: response.data))
        } else {
            completion(.failure(error: response.error))
        }
    }
    
    func getAllVehicles () -> Results<Vehicle> {
        parkingController.getAllParkedVehicles()
    }
    
}
