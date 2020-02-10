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
    
    var parkingController: ParkingService!
    var dateComponentsEntrance: DateComponents!
    var someDate: Date!
    var dateComponentsOut: DateComponents!
    var vehicle: Vehicle!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        parkingController = ParkingService()
        dateComponentsEntrance = DateComponents()
        dateComponentsOut = DateComponents()
        setupDateComponentsOut()
        setupDateComponentsIn()
        setupVehicle()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func setupVehicle () {
        let userCalendar = Calendar.current
        let someDate = userCalendar.date(from: dateComponentsEntrance)
        vehicle = Vehicle(licencePlate: "AAA", type: "MOTORCYCLE", cc: 0, date: someDate!)
    }
    
    func setupDateComponentsOut () {
        dateComponentsOut = Calendar.current.dateComponents([.day, .hour, .month], from: Date())
    }
    
    func setupDateComponentsIn () {
        dateComponentsEntrance = Calendar.current.dateComponents([.day, .hour, .month], from: Date())
        
        dateComponentsEntrance.year = 2020
        dateComponentsEntrance.day = dateComponentsOut.day! - 2
        dateComponentsEntrance.hour = dateComponentsOut.hour! - 14
        dateComponentsEntrance.minute = 30
        dateComponentsEntrance.timeZone = .current
    }
    
//    func testMotorcycleIsGreaterThan500CC () {
//        //Arrange
//        vehicle.cc = 650
//        //Act
//        let condition = parkingController.isGreaterThan500CC(vehicle: vehicle)
//        //Assert
//        XCTAssertEqual(condition, true)
//    }
//    
//    func testCalculateTimeInTheParking () {
//        //Arrange
//        
//        //Act
//        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
////        parkingController.calculateTime(vehicle: vehicle)
//        
//        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
//        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
//            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
//            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
//        
//        //Assert
//        XCTAssertEqual(timeInTheParking.0, days)
//        XCTAssertEqual(timeInTheParking.1, hours)
//        
//    }
//    
//    func testCalculatePayCar () {
//        //Arrange
//        vehicle.type = "CAR"
//        
//        //Act
//        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
//        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
//            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
//            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
//        
//        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
//        let totalToPay = parkingController.calculatePayCar(vehicle: vehicle, totalTime: timeInTheParking)
//        
//        //Assert
//        XCTAssertEqual(totalToPay, (CarPrices.day.rawValue * Float(days)) + (CarPrices.hour.rawValue * Float(hours)))
//        
//    }
//    
//    func testCalculatePayMotorcycleIfNot500CC () {
//        //Arrange
//        vehicle.cc = 200
//        
//        //Act
//        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
//        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
//            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
//            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
//        
//        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
//        let totalToPay = parkingController.calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
//        
//        //Assert
//        XCTAssertEqual(totalToPay, (MotorcyclePrices.day.rawValue * Float(days)) + (MotorcyclePrices.hour.rawValue * Float(hours)))
//    }
//    
//    func testCalculatePayMotorcycleIf500CC () {
//        //Arrange
//        vehicle.cc = 650
//        
//        //Act
//        let days = dateComponentsOut.day! - dateComponentsEntrance.day!
//        let hours = dateComponentsEntrance.hour! > dateComponentsOut.hour!
//            ? 24 - (dateComponentsEntrance.hour! - dateComponentsOut.hour!)
//            : dateComponentsOut.hour! - dateComponentsEntrance.hour!
//        
//        let timeInTheParking = parkingController.calculateTimeInTheParking(vehicle: vehicle)
//        let totalToPay = parkingController.calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
//        
//        //Assert
//        XCTAssertEqual(totalToPay, (MotorcyclePrices.day.rawValue * Float(days)) + (MotorcyclePrices.hour.rawValue * Float(hours)) + MotorcyclePrices.extraCC.rawValue)
//    }
//    
//    func testIfParkingIsNotFull () { //MOCK
//        //Arrange
//        
//        //Act
//        let added = parkingController.registerEntryToTheParking(vehicle: vehicle)
//        let str = added.data as! String
//        //Assert
//        XCTAssertEqual(str, "Vehicle added successfully!")
//    }
//    
//    func testParkingIsFull () {
//        
//    }

}
