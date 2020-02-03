//
//  Parqueadero.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class ParkingController {
    
    var vehicles: [Vehicle] = []
    let parkingDAO: ParkingDAO = ParkingDAO()
    var vehicleTypes: [VehicleTypec] = []
    
    func addVehicleToTheParking (vehicle: Vehicle) -> String {
        if vehicles.count <= 30 {
            parkingDAO.insert(vehicle)
            return "Vehicle added successfully!"
        } else {
            return "Parking is full :("
        }
    }
    
    private func removeVehicleInTheParking (vehicle: Vehicle) {
        parkingDAO.removeFromParking(vehicle)
    }
    
    private func getAllParkedVehicles () {
        parkingDAO.getAllParkedVehicles()
    }
    
    func isGreaterThan500CC (vehicle: Vehicle) -> Bool {
        return vehicle.cc > 500
    }
    
    func calculateTimeInTheParking (vehicle: Vehicle) -> (Int, Int) {
        let currentDateComponents = Calendar.current.dateComponents(in: .current, from: Date())
        let vehicleDateComponents = Calendar.current.dateComponents(in: .current, from: vehicle.date)
        
        let days = currentDateComponents.day! - vehicleDateComponents.day!
        let hours = days == 0
            ? currentDateComponents.hour! - vehicleDateComponents.hour!
            : 24 - (vehicleDateComponents.hour! - currentDateComponents.hour!)
        
        return (days, hours)
    }
    
    func calculatePayMotorcycle (vehicle: Vehicle, totalTime: (Int, Int)) -> Float {
        var totalToPay: Float = 0
        let numberOfDays = Float(totalTime.0)
        let numberOfHours = Float(totalTime.1)
        let greaterThan500CC = isGreaterThan500CC(vehicle: vehicle)
        
        if numberOfDays > 0 {
            totalToPay = greaterThan500CC
                ? (MotorcyclePrices.day.rawValue * numberOfDays) + (MotorcyclePrices.day.rawValue * numberOfHours) + MotorcyclePrices.extraCC.rawValue
                : (MotorcyclePrices.day.rawValue * numberOfDays) + (MotorcyclePrices.day.rawValue * numberOfHours)
        } else {
            totalToPay = !greaterThan500CC
                ? (MotorcyclePrices.hour.rawValue * numberOfHours) + MotorcyclePrices.extraCC.rawValue
                : MotorcyclePrices.hour.rawValue * numberOfHours
        }
        return totalToPay
    }
    
    func calculatePayCar (vehicle: Vehicle, totalTime: (Int, Int)) -> Float {
        var totalToPay: Float = 0
        let numberOfDays = Float(totalTime.0)
        let numberOfHours = Float(totalTime.1)
        
        if numberOfDays > 0 {
            totalToPay = (CarPrices.day.rawValue * numberOfDays) + (CarPrices.day.rawValue * numberOfHours)
        } else {
            totalToPay = CarPrices.hour.rawValue * numberOfHours
        }
        
        return totalToPay
    }
    
    func findVehicleIntoTheParking (licencePlate: String) -> Vehicle {
        return Vehicle()
    }
    
    func calculatePay (vehicle: Vehicle) -> Float {
        var priceToPay: Float = 0
        let timeInTheParking = calculateTimeInTheParking(vehicle: vehicle)
        
        if vehicle.type.typeName == "Motorcycle" {
            priceToPay = calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
        } else {
            priceToPay = calculatePayCar(vehicle: vehicle, totalTime: timeInTheParking)
        }
        removeVehicleInTheParking(vehicle: vehicle)
        return priceToPay
    }
}
