//
//  Helper.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/17/21.
//

import UIKit

let formatterVar: DateFormatter? = {
    var formatter = DateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
    formatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
    return formatter
}()
var apiDate: Date? = nil

class Helper: NSObject {
    class func getDateFromAPIDateString(_ dateString: String?) -> Date? {
        var apiDate = Date()
        if (dateString != nil) {
            //2015-10-13T15:37:43.24
            let dateArray = dateString?.components(separatedBy: "T")
            if (dateArray?.count ?? 0) == 2 {
                apiDate = dateFromString(from: "\(dateArray?.first ?? "") \(dateArray?.last ?? "")", withFormat: "YYYY-MM-dd HH:mm:ss.SSSZ") ?? Date()
                let timeString = dateArray?[1].components(separatedBy: ".").first
                if apiDate == nil {
                    apiDate = dateFromString(from: "\(dateArray?.first ?? "") \(timeString ?? "")", withFormat: "YYYY-MM-dd HH:mm:ss") ?? Date()
                }
                // sometime we are getting date with Z, try another format
                if apiDate == nil {
                    apiDate = dateFromString(from: "\(dateArray?.first ?? "") \(timeString ?? "")", withFormat: "YYYY-MM-dd HH:mm:ssZ") ?? Date()
                }
            }
        }
        return apiDate
    }
    
    class func formatter() -> DateFormatter? {
        return formatterVar
    }
    
    class func dateFromString(from dateStr: String?, withFormat format: String?) -> Date? {
        if !dateStr!.isEmpty && (format != nil) {
            let formatter = self.formatter()
            formatter?.dateFormat = format
            return formatter?.date(from: dateStr ?? "")
        }
        return nil
    }

}
