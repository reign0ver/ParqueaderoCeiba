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
        //Arrange
        let byke = Vehicle()
        byke.cc = 650
        //Act
        let condition = parkingController.isGreaterThan500CC(vehicle: byke)
        //Assert
        XCTAssertEqual(condition, true)
    }
    
    func testCalculateTimeInTheParking () {
        //Arrange
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        vehicle.date = someDate!
        
        //Act
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        //Assert
        XCTAssertEqual(timeInTheParking.0, days)
        XCTAssertEqual(timeInTheParking.1, hours)
        
    }
    
    func testCalculatePayCar () {
        //Arrange
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        vehicle.date = someDate!
        
        //Act
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let totalToPay = parkingController.calculatePayCar(vehicle: vehicle, totalTime: timeInTheParking)
        
        //Assert
        XCTAssertEqual(totalToPay, (CarPrices.day.rawValue * Float(days)) + (CarPrices.hour.rawValue * Float(hours)))
        
    }
    
    func testCalculatePayMotorcycleIfNot500CC () {
        //Arrange
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        vehicle.date = someDate!
        vehicle.cc = 200
        
        //Act
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let totalToPay = parkingController.calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
        
        //Assert
        XCTAssertEqual(totalToPay, (MotorcyclePrices.day.rawValue * Float(days)) + (MotorcyclePrices.hour.rawValue * Float(hours)))
    }
    
    func testCalculatePayMotorcycleIf500CC () {
        //Arrange
        let vehicle = Vehicle()
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        vehicle.date = someDate!
        vehicle.cc = 650
        
        //Act
        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
        
        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
        let totalToPay = parkingController.calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
        
        //Assert
        XCTAssertEqual(totalToPay, (MotorcyclePrices.day.rawValue * Float(days)) + (MotorcyclePrices.hour.rawValue * Float(hours)) + MotorcyclePrices.extraCC.rawValue)
    }
    
    func testIfParkingIsNotFull () {
        //Arrange
        let vehicle = Vehicle()
        //Act
        let str = parkingController.addVehicleToTheParking(vehicle: vehicle)
        //Assert
        XCTAssertEqual(str, "Vehicle added successfully!")
    }
    
    func testParkingIsFull () {
        
    }

}
