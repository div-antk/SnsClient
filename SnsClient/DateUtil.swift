//
//  DateUtil.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/23.
//

import Foundation

class DateUtil {
    
    class func dateFromString(string: String, format: String) -> Date {
        let formatter = ISO8601DateFormatter()
//        formatter.calendar = Calendar(identifier: .gregorian)
//        formatter.dateFormat = format
        return formatter.date(from: string) ?? Date()
    }

    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

