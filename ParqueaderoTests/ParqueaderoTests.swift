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
    
    var getInService: GetInVehicleService!
    var getOutService: GetOutVehicleService!
    var dateComponentsEntrance: DateComponents!
    var someDate: Date!
    var dateComponentsOut: DateComponents!
    var vehicle: Vehicle!
    
    override func setUp() {
        getInService = GetInVehicleService()
        getOutService = GetOutVehicleService()
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
    
    func testCalculateTimeInTheParking () {
        //Arrange
        let seconds = vehicle.date.distance(to: Date())
        var days: Int = Int(seconds / Constants.dayInSeconds)
        var hours: Double = seconds / Constants.hourInSeconds
        var approxHours: Int
        
        hours -= Double(days) * Constants.dayInHours
        if hours > Constants.maxHoursPerDay {
            days += 1
            hours -= Constants.maxHoursPerDay
        }
        approxHours = Int(hours) + 1
        //Act
        let (daysResult, hoursResult) = CalculateTimeService.calculateTime(vehicle: vehicle)
        //Assert
        XCTAssertEqual(daysResult, days)
        XCTAssertEqual(hoursResult, approxHours)
    }
    
    func testCanGetInWhenLicencePlateStartsWithA () {
        //Arrange
        let expectedMessage = "You cannot get in :(.  Your licence plate is only allowed to entry on Sunday and Monday"
        //Act
        
        //Assert
    }
    
    func testAlreadyExistsTheVehicleInThePark () {
        //Arrange
        
        //Act
        
        //Assert
    }
    
    func testCanGetInWhenCarLimitIsReached () {
        //Arrange
        
        //Act
        
        //Assert
    }
    
    func testCanGetInWhenMotoLimitIsReached () {
        //Arrange
        
        //Act
        
        //Assert
    }
    
}
