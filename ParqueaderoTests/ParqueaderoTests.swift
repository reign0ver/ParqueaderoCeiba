//
//  ParqueaderoTests.swift
//  ParqueaderoTests
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 28/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import XCTest
@testable import Parqueadero

class ParqueaderoTests: XCTestCase {
    
    var parkingController: ParkingController!
    var dateComponents: DateComponents!
    var someDate: Date!
    var currentDateComponents: DateComponents!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        parkingController = ParkingController()
        dateComponents = DateComponents()
        setupRandomDateIntoDateComponents()
        currentDateIntoDateComponents()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func currentDateIntoDateComponents () {
        currentDateComponents = Calendar.current.dateComponents([.day, .hour], from: Date())
    }
    
    func setupRandomDateIntoDateComponents () {
        dateComponents.year = 2020
        dateComponents.month = 2
        dateComponents.day = 3
        dateComponents.hour = 7
        dateComponents.minute = 30
        dateComponents.timeZone = .current
    }
    
    func testMotorcycleIsGreaterThan500CC () {
        let byke = Vehicle()
        byke.cc = 650
        let condition = parkingController.isGreaterThan500CC(vehicle: byke)
        XCTAssertEqual(condition, true)
    }
    
    func testCalculateTimeInTheParking () {
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponents)
        
        vehicle.date = someDate!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        XCTAssertEqual(timeInTheParking.0, currentDateComponents.day! - dateComponents.day!)
        XCTAssertEqual(timeInTheParking.1, currentDateComponents.hour! - dateComponents.hour!)
        
    }
    
    func testCalculatePayCar () {
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponents)
        
        vehicle.date = someDate!
        let numberOfHours = currentDateComponents.hour! - dateComponents.hour!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let totalToPay = parkingController.calculatePayCar(vehicle: vehicle, totalTime: timeInTheParking)
        XCTAssertEqual(totalToPay, CarPrices.hour.rawValue * Float(numberOfHours))
    }

}
