//
//  DateFormatter+Utils.swift
//  Leboncoin
//
//  Created by Renxiao Mo on 14/02/2023.
//

import Foundation

extension DateFormatter {
    static var dayMonthHourMinFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM HH:mm"
        formatter.locale = Locale(identifier: "FR-fr")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        return formatter
    }
    
    static var serverDateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.locale = Locale(identifier: "FR-fr")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()

}
