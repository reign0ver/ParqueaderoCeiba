//
//  Parqueadero.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 30/01/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation
import RealmSwift

class ParkingService {
    
    let parkingDAO: ParkingDAOImpl = ParkingDAOImpl()
    
    func addVehicleToTheParking (vehicle: Vehicle) -> Response<Any> {
        let response = isParkingFull()
        if response.status {
            parkingDAO.insert(vehicle)
            return Response(status: true, data: "Vehicle added successfully!", error: "")
        } else {
            return response
        }
    }
    
    func isParkingCarFull (vehicles: [Vehicle]) -> Int8 {
        var carCant: Int8 = 0
        for v in vehicles {
            if v.type == "Car" {
                carCant += 1
            }
        }
        return carCant
    }
    
    func isParkingMotoFull (vehicles: [Vehicle]) -> Int8 {
        var motoCant: Int8 = 0
        for v in vehicles {
            if v.type == "Motorcycle" {
                motoCant += 1
            }
        }
        return motoCant
    }
    
    func isParkingFull () -> Response<Any> {
        let vehicles = parkingDAO.getAllParkedVehicles()
        let carCant = isParkingCarFull(vehicles: vehicles)
        let motoCant = isParkingMotoFull(vehicles: vehicles)
        
        if carCant > 20 {
            return Response(status: false, data: "", error: "Full of cars :(")
        } else if motoCant > 10 {
            return Response(status: false, data: "", error: "Full of motos :(")
        }
        return Response(status: true, data: "", error: "")
    }
    
    func removeVehicleInTheParking (_ vehicle: Vehicle) {
        parkingDAO.removeFromParking(vehicle)
    }
    
    func getAllParkedVehicles () -> [Vehicle] {
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
        return Vehicle(licencePlate: "", type: "", cc: 0, date: Date())
    }
    
    func calculatePay (vehicle: Vehicle) -> Response<Any> {
        var priceToPay: Float = 0
        let timeInTheParking = calculateTimeInTheParking(vehicle: vehicle)
        
        if vehicle.type == "Motorcycle" {
            priceToPay = calculatePayMotorcycle(vehicle: vehicle, totalTime: timeInTheParking)
        } else if vehicle.type == "Car" {
            priceToPay = calculatePayCar(vehicle: vehicle, totalTime: timeInTheParking)
        } else {
            return Response(status: false, data: "", error: "Vehicle type not found")
        }
        removeVehicleInTheParking(vehicle)
        return Response(status: true, data: priceToPay, error: "")
    }
}
