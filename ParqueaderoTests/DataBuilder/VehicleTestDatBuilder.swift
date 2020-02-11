//
//  VehicleTestDatBuilder.swift
//  ParqueaderoTests
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 11/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
@testable import Parqueadero

class VehicleTestDataBuilder {
    var licencePlate: String
    var type: String
    var cc: Int16
    var date: Date
    
    init() {
        self.licencePlate = "Default Value"
        self.type = "Default Value"
        self.cc = 0
        self.date = Date()
    }
    
    func withLicencePlate (_ licencePlate: String) {
        self.licencePlate = licencePlate
    }
    
    func withType (_ type: String) {
        self.type = type
    }
    
    func withCC (_ cc: Int16) {
        self.cc = cc
    }
    
    func withDate (_ date: Date) {
        self.date = date
    }
    
    func build () -> Vehicle {
        return Vehicle(licencePlate: licencePlate, type: type, cc: cc, date: date)
    }
}
