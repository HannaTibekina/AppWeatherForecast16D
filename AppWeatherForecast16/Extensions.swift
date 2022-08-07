//
//  Extensions.swift
//  AppWeatherForecast16
//
//  Created by Анна Тибекина on 08.08.2022.
//


import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension String {

    func dayOfWeek() -> String  {
        
//        let f = DateFormatter()
//
//        f.weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1]
//        return f
        
        let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                let weekDay = dateFormatter.string(from: Date())
                return weekDay
    }
}
      
    
