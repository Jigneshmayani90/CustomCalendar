//
//  CalendarHelper.swift
//  RRCustomCalendar
//
//  Created by Rahul on 07/05/22.
//

import Foundation

extension Date {
    
    private var calendar: Calendar { Calendar.current }
    
    var plusMonth: Date {
        calendar.date(byAdding: .month, value: 1, to: self)!
    }
    
    var minusMonth: Date {
        calendar.date(byAdding: .month, value: -1, to: self)!
    }
    
    var monthString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: self)
    }
    
    var yearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var dayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: self)!.count
    }
    
    var dayOfMonth: Int {
        calendar.dateComponents([.day], from: self).day!
    }
    
    var firstOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
    
    var weekDay: Int {
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday! - 1
    }
}

extension String {
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d LLLL yyyy"
        return dateFormatter.date(from:self)!
    }
}
