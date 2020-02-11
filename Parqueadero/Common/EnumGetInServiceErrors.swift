//
//  EnumGetInServiceErrors.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 11/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

enum GetInServiceErrors: String, Error {
    case parkingIsFull = "Parking is full :("
    case licencePlateNotAllowed = "You cannot get in :(.  Your licence plate is only allowed to entry on Sunday and Monday"
    case alreadyExists = "The vehicle you're trying to register is already in the park"
}
