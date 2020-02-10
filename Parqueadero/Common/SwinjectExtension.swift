//
//  SwinjectExtension.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 10/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import Swinject

class SwinjectServices {
    
    let container = Container()
    
    func setup () {
        container.register(ParkingModel.self) { r in
            ParkingModel(getInService: r.resolve(GetInVehicleService.self)!,
                         getOutService: r.resolve(GetOutVehicleService.self)!,
                         listVehiclesService: r.resolve(ListVehiclesService.self)!)
        }
    }
}
