//
//  Month-ViewModel.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 06.09.2024.
//

import SwiftUI
import CoreData

final class MonthViewModel: ObservableObject {
    
    private var context: NSManagedObjectContext
   
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // formatTime
    func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
     
        if hours > 0 {
            return "\(hours)h \(minutes)min"
        } else if minutes > 0 {
            return "\(minutes)min"
        } else {
            return "0min"
        }
    }

    
    // Current Month
    func currentMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: Date())
    }
    
    func totalMonthlyTime(hobbies: FetchedResults<Hobby>) -> Double {
        Double(hobbies.reduce(0) { $0 + ($1.monthlyTime) })
    }
    
    
    // Time Per Day
    func averageTimePerDay(hobbies: FetchedResults<Hobby>) -> Double {
        let totalTime = totalMonthlyTime(hobbies: hobbies)
        let currentDay = Calendar.current.component(.day, from: Date())
        
        guard currentDay > 0 else { return 0 }
        
        return totalTime / Double(currentDay)
    }
    
    // Time One Hobby
    func averageTimeOneHobby(for hobby: Hobby) -> Double {
        let totalTime = hobby.monthlyTime
        let currentDay = Calendar.current.component(.day, from: Date())
        
        guard currentDay > 0 else { return 0 }
        
        return totalTime / Double(currentDay)
    }
    
    // Rest Time   
    func averageRestTime(hobbies: FetchedResults<Hobby>) -> String {
        let workTimeWithSleep = 86400.0 - 28800.0 // 24h - sleep time user
        let timePerDay = averageTimePerDay(hobbies: hobbies)
         
        // average rest time
        let restTime = workTimeWithSleep - timePerDay
        return formatTime(restTime)
    }
}
