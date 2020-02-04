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
    var dateComponentsEntrance: DateComponents!
    var someDate: Date!
    var dateComponentsOut: DateComponents!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        parkingController = ParkingController()
        dateComponentsEntrance = DateComponents()
        dateComponentsOut = DateComponents()
        setupDateComponentsOut()
        setupDateComponentsIn()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setupDateComponentsOut () {
        dateComponentsOut = Calendar.current.dateComponents([.day, .hour, .month], from: Date())
    }
    
    func setupDateComponentsIn () {
        
        dateComponentsEntrance = Calendar.current.dateComponents([.day, .hour, .month], from: Date())
        
        dateComponentsEntrance.day = dateComponentsOut.day! - 1
        dateComponentsEntrance.hour = dateComponentsOut.hour! - 5
        dateComponentsEntrance.minute = 30
        dateComponentsEntrance.timeZone = .current
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
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        
        vehicle.date = someDate!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        XCTAssertEqual(timeInTheParking.0, days)
        XCTAssertEqual(timeInTheParking.1, hours)
        
    }
    
    func testCalculatePayCar () {
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        
        vehicle.date = someDate!
        
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let totalToPay = parkingController.calculatePayCar(vehicle: vehicle, totalTime: timeInTheParking)
        XCTAssertEqual(totalToPay, (CarPrices.day.rawValue * Float(days)) + (CarPrices.hour.rawValue * Float(hours)))
        
    }
    
    func testCalculatePayMotorcycleIfNot500CC () {
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        
        vehicle.date = someDate!
        vehicle.cc = 200
        
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let totalToPay = parkingController.calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
        XCTAssertEqual(totalToPay, (MotorcyclePrices.day.rawValue * Float(days)) + (MotorcyclePrices.hour.rawValue * Float(hours)))
    }
    
    func testCalculatePayMotorcycleIf500CC () {
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        
        vehicle.date = someDate!
        vehicle.cc = 650
        
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let totalToPay = parkingController.calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
        XCTAssertEqual(totalToPay, (MotorcyclePrices.day.rawValue * Float(days)) + (MotorcyclePrices.hour.rawValue * Float(hours)) + MotorcyclePrices.extraCC.rawValue)
    }
    
    func testIfParkingIsNotFull () {
        let vehicle = Vehicle()
        let str = parkingController.addVehicleToTheParking(vehicle: vehicle)
        XCTAssertEqual(str, "Vehicle added successfully!")
    }

}
