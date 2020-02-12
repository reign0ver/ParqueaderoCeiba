//
//  ParqueaderoTests.swift
//  ParqueaderoTests
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 28/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import XCTest
import Swinject
@testable import Parqueadero

class ParqueaderoTests: XCTestCase {
    
    var getInService: GetInVehicleService!
    var getOutService: GetOutVehicleService!
    var vehicleDataBuilder: VehicleTestDataBuilder!
    var dateDataBuilder: DateDataBuilder!
    
    let container: Container = {
        let container = Container()
        container.register(ParkingDAOProtocol.self) { _ in
            ParkingDAOImplTest()
        }
        container.register(GetInVehicleService.self) { r in
            GetInVehicleService(parkingDAO: r.resolve(ParkingDAOProtocol.self)!)
        }
        return container
    }()
    
    override func setUp() {
        dateDataBuilder = DateDataBuilder()
        vehicleDataBuilder = VehicleTestDataBuilder()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalculateTimeInTheParkingWithHours () {
        //Arrange
        dateDataBuilder.withDays(2)
        dateDataBuilder.withHours(5)
        dateDataBuilder.withMinutes(30)
        
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (daysResult, hoursResult) = CalculateTimeService.calculateTime(vehicle: vehicle)
        //Assert
        XCTAssertEqual(2, daysResult)
        XCTAssertEqual(6, hoursResult)
    }
    
    func testCalculateTimeInTheParkingFullDays () {
        //Arrange
        dateDataBuilder.withDays(2)
        dateDataBuilder.withHours(7)
        dateDataBuilder.withMinutes(-1)
        
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (daysResult, hoursResult) = CalculateTimeService.calculateTime(vehicle: vehicle)
        //Assert
        XCTAssertEqual(2, daysResult)
        XCTAssertEqual(7, hoursResult)
    }
    
    func testCalculateTimeInTheParkingSmallerThan9Hrs () {
        //Arrange
        dateDataBuilder.withHours(5)
        dateDataBuilder.withMinutes(30)
        
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act
        let (daysResult, hoursResult) = CalculateTimeService.calculateTime(vehicle: vehicle)
        //Assert
        XCTAssertEqual(0, daysResult)
        XCTAssertEqual(6, hoursResult)
    }
    
    func testCanGetInWhenLicencePlateStartsWithA () {
        //Arrange
        vehicleDataBuilder.withLicencePlate("ABC123")
        dateDataBuilder.withFriday()
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act - Assert
        XCTAssertThrowsError(try container.resolve(GetInVehicleService.self)?.canVehicleGetInToday(vehicle.licencePlate))
    }
    
    func testAlreadyExistsTheVehicleInThePark () {
        //Arrange
        vehicleDataBuilder.withLicencePlate("ANC717")
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act - Assert
        XCTAssertThrowsError(try container.resolve(GetInVehicleService.self)?.alreadyExistInThePark(vehicle.licencePlate))
    }
    
    func testCanGetInWhenCarLimitIsReached () {
        //Arrange
        vehicleDataBuilder.withType(Constants.car)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act - Assert
        XCTAssertThrowsError(try container.resolve(GetInVehicleService.self)?.isParkingFullByVehicleType(vehicle.type))
    }
    
    func testCanGetInWhenMotoLimitIsReached () {
        //Arrange
        vehicleDataBuilder.withType(Constants.moto)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        //Act - Assert
        XCTAssertThrowsError(try container.resolve(GetInVehicleService.self)?.isParkingFullByVehicleType(vehicle.type))
    }
    
    func testCalculatePaymentCarFullDay () {
        //Arrange
        dateDataBuilder.withDays(2)
        dateDataBuilder.withHours(15)
        dateDataBuilder.withMinutes(30)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        let calculateCar = CalculatePaymentCar()
        //Act
        let totalToPay = calculateCar.calculatePayment(vehicle)
        //Assert
        XCTAssertEqual(totalToPay, 24000)
    }
    
    func testCalculatePaymentCarWithHours () {
        //Arrange
        dateDataBuilder.withDays(2)
        dateDataBuilder.withHours(4)
        dateDataBuilder.withMinutes(15)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        let calculateCar = CalculatePaymentCar()
        //Act
        let totalToPay = calculateCar.calculatePayment(vehicle)
        //Assert
        XCTAssertEqual(totalToPay, 21000)
    }
    
    func testCalculatePaymentMotorcycleFullDay () {
        //Arrange
        dateDataBuilder.withDays(2)
        dateDataBuilder.withHours(15)
        dateDataBuilder.withMinutes(30)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        let calculateMotorcycle = CalculatePaymentMotorcycle()
        //Act
        let totalToPay = calculateMotorcycle.calculatePayment(vehicle)
        //Assert
        XCTAssertEqual(totalToPay, 12000)
    }
    
    func testCalculatePaymentMotorcycleAfter1Hour () {
        //Arrange
        dateDataBuilder.withDays(3)
        dateDataBuilder.withHours(1)
        dateDataBuilder.withMinutes(1) //date entry is before the getoutdate
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        let calculateMotorcycle = CalculatePaymentMotorcycle()
        //Act
        let totalToPay = calculateMotorcycle.calculatePayment(vehicle)
        //Assert
        XCTAssertEqual(totalToPay, 13000)
    }
    
    func testCalculatePaymentMotorcycleBefore1Hour () {
        //Arrange
        dateDataBuilder.withDays(3)
        dateDataBuilder.withHours(1)
        dateDataBuilder.withMinutes(-1)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        let vehicle: Vehicle = vehicleDataBuilder.build()
        let calculateMotorcycle = CalculatePaymentMotorcycle()
        //Act
        let totalToPay = calculateMotorcycle.calculatePayment(vehicle)
        //Assert
        XCTAssertEqual(totalToPay, 12500)
    }
    
    func testCalculatePaymentMotorcycleWhenIsGreaterThan500 () {
        //Arrange
        dateDataBuilder.withDays(2)
        dateDataBuilder.withHours(15)
        dateDataBuilder.withMinutes(30)
        vehicleDataBuilder.withDate(dateDataBuilder.build())
        vehicleDataBuilder.withCC(650)
        let vehicle: Vehicle = vehicleDataBuilder.build()
        let calculateMotorcycle = CalculatePaymentMotorcycle()
        //Act
        let totalToPay = calculateMotorcycle.calculatePayment(vehicle)
        //Assert
        XCTAssertEqual(totalToPay, 14000)
    }
}
