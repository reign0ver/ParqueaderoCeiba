//
//  EnumModelResponse.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 11/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

enum ModelResponse <T> {
    case success (result: T)
    case failure (error: String)
}
