//
//  CalculateTimeService.swift
//  Parqueadero
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 6/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class CalculateTimeService {
    
    static func calculateTime (vehicle: Vehicle) -> (Int, Int) {
        let seconds = vehicle.date.distance(to: Date())
        var days: Int = Int(seconds / Constants.dayInSeconds)
        var hours: Double = seconds / Constants.hourInSeconds
        var approxHours: Int
        var hoursToPay: Int
        
        hours -= Double(days) * Constants.dayInHours
        if hours > Constants.maxHoursPerDay {
            days += 1
            hours = 0
        }
        hoursToPay = hours.truncatingRemainder(dividingBy: 1.0) > 0 ? Int(hours) + 1 : Int(hours)
        approxHours = hours == 0 ? 0 : hoursToPay
        return (days, approxHours)
    }
    
}
