//
//  Date+.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 09.08.2024.
//

import Foundation

// Extending Date to get Current Month Dates...
extension Date {
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
       
        // getting start date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
           
        // getting date...
        return range.compactMap { day -> Date in
         
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}
