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
    
    let parkingDAO: ParkingDAO = ParkingDAO()
    
    func addVehicleToTheParking (vehicle: Vehicle) -> String {
        if isParkingFull().status {
            parkingDAO.insert(vehicle)
            return "Vehicle added successfully!"
        } else {
            return "Parking is full :("
        }
    }
    
    func isParkingCarFull (vehicles: Results<Vehicle>) -> Int8 {
        var carCant: Int8 = 0
        for v in vehicles {
            if v.type!.typeName == "Car" {
                carCant += 1
            }
        }
        return carCant
    }
    
    func isParkingMotoFull (vehicles: Results<Vehicle>) -> Int8 {
        var motoCant: Int8 = 0
        for v in vehicles {
            if v.type!.typeName == "Motorcycle" {
                motoCant += 1
            }
        }
        return motoCant
    }
    
    func isParkingFull () -> Message {
        let vehicles = parkingDAO.getAllParkedVehicles()
        let carCant = isParkingCarFull(vehicles: vehicles)
        let motoCant = isParkingMotoFull(vehicles: vehicles)
        
        if carCant > 20 {
            return Message(status: false, message: "Full of cars :(")
        } else if motoCant > 10 {
            return Message(status: false, message: "Full of motos :(")
        }
        return Message(status: true, message: "")
    }
    
    func removeVehicleInTheParking (_ vehicle: Vehicle) {
        parkingDAO.removeFromParking(vehicle)
    }
    
    func getAllParkedVehicles () -> Results<Vehicle> {
        return parkingDAO.getAllParkedVehicles()
    }
    
    func isGreaterThan500CC (vehicle: Vehicle) -> Bool {
        return vehicle.cc > 500
    }
    
    func calculateTimeInTheParking (vehicle: Vehicle) -> (Int, Int) {
        let currentDateComponents = Calendar.current.dateComponents(in: .current, from: Date())
        let vehicleDateComponents = Calendar.current.dateComponents(in: .current, from: vehicle.date)
        
        let days = currentDateComponents.day! - vehicleDateComponents.day! //cambiar por las 9 hrs
        let hours = vehicleDateComponents.hour! > currentDateComponents.hour!
            ? 24 - (vehicleDateComponents.hour! - currentDateComponents.hour!)
            : currentDateComponents.hour! - vehicleDateComponents.hour!
        
        return (days, hours)
    }
    
    func calculatePayMotorcycle (vehicle: Vehicle, totalTime: (Int, Int)) -> Float {
        var totalToPay: Float = 0
        let numberOfDays = Float(totalTime.0)
        let numberOfHours = Float(totalTime.1)
        let greaterThan500CC = isGreaterThan500CC(vehicle: vehicle)
        
        if numberOfDays > 0 {
            totalToPay = greaterThan500CC
                ? (MotorcyclePrices.day.rawValue * numberOfDays) + (MotorcyclePrices.hour.rawValue * numberOfHours) + MotorcyclePrices.extraCC.rawValue
                : (MotorcyclePrices.day.rawValue * numberOfDays) + (MotorcyclePrices.hour.rawValue * numberOfHours)
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
            totalToPay = (CarPrices.day.rawValue * numberOfDays) + (CarPrices.hour.rawValue * numberOfHours)
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
        } else if vehicle.type.typeName == "Car" {
            priceToPay = calculatePayCar(vehicle: vehicle, totalTime: timeInTheParking)
        }
        removeVehicleInTheParking(vehicle)
        return priceToPay
    }
}
