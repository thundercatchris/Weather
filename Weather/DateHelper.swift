//
//  DateFormat.swift
//  Weather
//
//  Created by Cerebro on 21/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation

class DateHelper {
    
    func reformatDateString(dateString: String, oldFormat: String, newFormat: String) -> String? {
        let startingDateFormatter = DateFormatter()
        startingDateFormatter.dateFormat = oldFormat
        if let date = startingDateFormatter.date(from: dateString) {
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = newFormat
            
            let newDate = newDateFormatter.string(from: date)
            return newDate
            
        }
        return nil
    }
    
    func stringFromDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    func  dateFromString(dateString: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return nil
    }
    
    func detailsAreWithinLast24Hours(dateString: String) -> Bool {
            var date:Date?
            if let formatted = DateHelper().dateFromString(dateString: dateString, format: "yyyy-MM-dd-HH:mm") {
                    date = formatted
                
            }
        if let date = date, let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour, diff < 24 {
            return true
        } else {
            return false
        }
    }
    
}
