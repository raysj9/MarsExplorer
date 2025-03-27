//
//  Date+Extension.swift
//  MarsExplorer
//
//  Created by Jackson Ray on 3/26/25.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
