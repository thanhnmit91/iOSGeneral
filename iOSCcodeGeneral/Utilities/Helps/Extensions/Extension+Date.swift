//
//  Extension+Date.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

let dateTimeInstance = DateTimeInstance.shared
class DateTimeInstance: NSObject {
    
    static let shared = DateTimeInstance()
    
    let calendar = Calendar.current
    
    func getComponent(date: Date) -> DateComponents {
        return calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }
    
}


extension Date {
    
    func indexOfdateInWeek() -> Int? {
        let myCalendar = Calendar.current
        let weekDay = myCalendar.component(.weekday, from: self)
        return weekDay
    }
    
    func year() -> Int {
        return DateTimeInstance.shared.getComponent(date: self).year!
    }
    
    func month() -> Int {
        return DateTimeInstance.shared.getComponent(date: self).month!;
    }
    
    func day() -> Int {
        return DateTimeInstance.shared.getComponent(date: self).day!;
    }
    
    func hour() -> Int {
        return DateTimeInstance.shared.getComponent(date: self).hour!;
    }
    
    func minute() -> Int {
        return DateTimeInstance.shared.getComponent(date: self).minute!;
    }
    
    func add(day : Int)-> Date {
        var component = DateComponents.init()
        component.day = day
        return DateTimeInstance.shared.calendar .date(byAdding: component, to: self)!
    }
    
    /**
     *  compare year/month/day/hour/min/sec
     */
    func isAbsolutelyAfter(date : Date) -> Bool {
        if self.compare(date) == ComparisonResult.orderedAscending {
            return false
        }
        else {
            return true
        }
    }
    
    /**
     *  compare year/month/day/hour/min/sec
     */
    func isAbsolutelyBefore(date : Date) ->Bool {
        return !isAbsolutelyAfter(date: date)
    }
    
    /**
     *  compare year/month/day
     */
    func isTheSameDay(target : Date)->Bool {
        let date2 = target
        let date1 = self
        if(date1.year() == date2.year() && date1.month() == date2.month() && date1.day() == date2.day()) {
            return true
        }
        return false
    }
    
    /**
     *  compare year/month/day
     */
    func isBefore(date: Date) -> Bool {
        let d1 = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
        let d2 = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        if d1.compare(d2) == .orderedDescending {
            return true
        }
        return false
    }
    
    /**
     *  get date in week of current date
     */
    func dateInWeek() -> [Date] {
        var output : [Date]  = []
        for i in   2...8 {
            let unitDate : Date = self.add(day: i - ( self.indexOfdateInWeek()!))
            output.append(unitDate)
        }
        return output
    }
    
    /**
     *  get index of current week in year
     */
    func getIndexWeekOfYear() -> Int {
        var index = 0
        index = Calendar.current.component(.weekOfYear, from: self)
        return index
    }
    
    /**
     *  adding month
     */
    func addingMonth(months: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        
        var components = DateComponents()
        components.calendar = calendar
        components.timeZone = TimeZone(secondsFromGMT: 0)
        components.month = months
        
        return calendar.date(byAdding: components, to: self)
    }
    
    
    /**
     *  get weekday name
     */
    func getWeekdayName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "vni_VN")
        dateFormatter.dateFormat = "EEEE"
        let currentDateString: String = dateFormatter.string(from: self)
        return currentDateString
    }
    
    /**
     *  get session ???
     */
    func getSession() -> DateSession {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 0..<12 :
            return .morning
        case 12..<17 :
            return .afternoon
        case 17..<24 :
            return .night
        default:
            return .unknow
        }
    }
    
    func getWeekday() -> Weekday {
        let str = Date().getWeekdayName()
        let weekday = Weekday(fromEnglishName: str)
        return weekday
    }
    
    func getUnix() -> Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func getFirstDayInMonth() -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    func getLastDayInMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        components.day = -1
        components.hour = 23
        components.minute = 59
        components.second = 59
        let endOfMonth = calendar.date(byAdding: components, to: self.getFirstDayInMonth())!
        return endOfMonth
    }
    
    init(unix: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(unix) / 1000)
    }
    
    func getString(withFormat format: String) -> String {
        var output: String = ""
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        output = formatter.string(from: self)
        return output
    }
}

class Weekday: NSObject {
    
    var name: String = ""
    var id: Int = -1
    var vietnameseName: String = ""
    
    init(fromEnglishName str: String) {
        self.name = str
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        for symbol in formatter.weekdaySymbols {
            if symbol.uppercased() == str.uppercased() {
                self.id = (formatter.weekdaySymbols?.firstIndex(of: symbol))!
            }
        }
        switch str.uppercased() {
        case "SUNDAY":
            self.vietnameseName = "Chủ nhật"
        case "MONDAY":
            self.vietnameseName = "Thứ 2"
        case "TUESDAY":
            self.vietnameseName = "Thứ 3"
        case "WEDNESDAY":
            self.vietnameseName = "Thứ 4"
        case "THURSDAY":
            self.vietnameseName = "Thứ 5"
        case "FRIDAY":
            self.vietnameseName = "Thứ 6"
        case "SATURDAY":
            self.vietnameseName = "Thứ 7"
        default:
            self.vietnameseName = ""
        }
    }
    
    func getShortVietnameseName() -> String {
        switch self.name.uppercased() {
        case "SUNDAY":
            return "CN"
        case "MONDAY":
            return "T2"
        case "TUESDAY":
            return "T3"
        case "WEDNESDAY":
            return "T4"
        case "THURSDAY":
            return "T5"
        case "FRIDAY":
            return "T6"
        case "SATURDAY":
            return "T7"
        default:
            return ""
        }
    }
    
    class func listed() -> [Weekday] {
        var list: [Weekday] = []
        let defaultList = DateFormatter().weekdaySymbols as [String]
        for name in defaultList {
            let weekday = Weekday(fromEnglishName: name)
            list.append(weekday)
        }
        return list
    }
}

enum DateSession {
    case morning
    case afternoon
    case night
    case unknow
}
