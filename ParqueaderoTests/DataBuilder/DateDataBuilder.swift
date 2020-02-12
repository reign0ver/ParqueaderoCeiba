//
//  DateDataBuilder.swift
//  ParqueaderoTests
//
//  Created by Andrés Enrique Carrillo Miranda - Ceiba Software on 12/02/20.
//  Copyright © 2020 Andrés Enrique Carrillo Miranda - Ceiba Software. All rights reserved.
//

import Foundation

class DateDataBuilder {
    
    var dateComponents: DateComponents
    
    var year: Int
    var month: Int
    var day: Int
    var hour: Int
    var minute: Int
    
    init() {
        self.dateComponents = DateComponents()
        self.dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        self.year = dateComponents.year!
        self.month = dateComponents.month!
        self.day = dateComponents.day!
        self.hour = dateComponents.hour!
        self.minute = dateComponents.minute!
    }
    
    func withYear (_ year: Int) {
        dateComponents.year = year
    }
    
    func withMonth (_ month: Int) {
        dateComponents.month = month
    }
    
    func withDays (_ days: Int) { //resta dias a partir del dia actual
        dateComponents.day = dateComponents.day! - days
    }
    
    func withHours (_ hours: Int) {
        dateComponents.hour = dateComponents.hour! - hours
    }
    
    func withMinutes (_ minutes: Int) { //set minutos especificos
        dateComponents.minute = dateComponents.minute! - minutes
    }
    
    func withFriday () {
        dateComponents.year = 2020
        dateComponents.day = 14 // it's friday
        dateComponents.month = 2
    }
    
    func build () -> Date {
        return Calendar.current.date(from: dateComponents) ?? Date()
    }
}
