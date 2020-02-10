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

class ParkingModel { //rename it pending - ParkingRepository(?)
    
    var getInService: GetInVehicleService!
    var getOutService: GetOutVehicleService!
    var listVehiclesService: ListVehiclesService!
    
    func addVehicle (_ vehicle: Vehicle, completion: @escaping ModelCompletion) {
        getInService = GetInVehicleService()
        let response = getInService.getInVehicle(vehicle)
        if response.success {
            completion(.success(result: response.data!))
        } else {
            completion(.failure(error: response.error!))
        }
    }
    
    func removeVehicleFromTheParking (_ vehicle: Vehicle, completion: @escaping ModelCompletion) {
        getOutService = GetOutVehicleService()
        let response = getOutService.getOutVehicle(vehicle)
        if response.success {
            completion(.success(result: response.data!))
        } else {
            completion(.failure(error: response.error!))
        }
    }
    
    func getAllVehicles () -> [Vehicle] {
        listVehiclesService = ListVehiclesService()
        return listVehiclesService.getAllParkedVehicles()
    }
    
}
