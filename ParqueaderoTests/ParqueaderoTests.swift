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
    var vehicleDataBuilder: VehicleTestDataBuilder!
    
    override func setUp() {
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
        vehicleDataBuilder = VehicleTestDataBuilder()
        vehicleDataBuilder.withDate(someDate!)
    }
    
    func setupDateComponentsOut () {
        dateComponentsOut = Calendar.current.dateComponents([.day, .hour, .month], from: Date())
    }
    
    func setupDateComponentsIn () {
        dateComponentsEntrance = Calendar.current.dateComponents([.day, .hour, .month], from: Date())
        
        dateComponentsEntrance.year = 2020
        dateComponentsEntrance.day = dateComponentsOut.day! - 2
        dateComponentsEntrance.hour = dateComponentsOut.hour! - 14
        dateComponentsEntrance.timeZone = .current
    }
    
    func setupFridayDay () -> Date { //seteo un viernes siempre para generar el error de la placa
        var dateComponents = DateComponents()
        dateComponents.year = 2020
        dateComponents.day = 14
        dateComponents.month = 2
        return Calendar.current.date(from: dateComponents)!
    }
    
    func testCalculateTimeInTheParking () {
        //Arrange
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (daysResult, hoursResult) = CalculateTimeService.calculateTime(vehicle: vehicle)
        //Assert
        XCTAssertEqual(3, daysResult)
        XCTAssertEqual(6, hoursResult)
    }
    
    func testCanGetInWhenLicencePlateStartsWithA () {
        //Arrange
        vehicleDataBuilder.withLicencePlate("ABC123")
        vehicleDataBuilder.withDate(setupFridayDay())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act - Assert
        XCTAssertThrowsError(try getInService.canVehicleGetInToday(vehicle.licencePlate))
    }
    
    func testAlreadyExistsTheVehicleInThePark () {
        //Arrange
//        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        
        //Assert
    }
    
    func testCanGetInWhenCarLimitIsReached () {
        //Arrange
        var vehicle: Vehicle = vehicleDataBuilder.build()
        vehicle.type = Constants.car
        //Act
        
        //Assert
        XCTAssertThrowsError(try getInService.isParkingFullByVehicleType(vehicle.type))
    }
    
    func testCanGetInWhenMotoLimitIsReached () {
        //Arrange
        var vehicle: Vehicle = vehicleDataBuilder.build()
        vehicle.type = Constants.moto
        //Act
        
        //Assert
        XCTAssertThrowsError(try getInService.isParkingFullByVehicleType(vehicle.type))
    }
    
}
