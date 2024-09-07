//
//  Month-ViewModel.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 06.09.2024.
//

import SwiftUI
import CoreData



final class MonthViewModel: ObservableObject {
    
    
    // Core Data
    private var viewContext: NSManagedObjectContext
    @Published var hobbies: [Hobby] = []
   
    init(context: NSManagedObjectContext) {
        self.viewContext = context
       fetchHobby()
    }
    
    private func fetchHobby() {
        let request: NSFetchRequest<Hobby> = Hobby.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)]
        
        do {
            hobbies = try viewContext.fetch(request)
        } catch {
            print("failed fetch")
        }
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
    
    
    func totalMonthlyTime() -> Double {
        Double(hobbies.reduce(0) { $0 + ($1.monthlyTime) })
    }
    
    func averageTimePerDay() -> Double {
        let totalTime = totalMonthlyTime()
        let currentDay = Calendar.current.component(.day, from: Date())
        
        guard currentDay > 0 else { return 0 }
        
        return totalTime / Double(currentDay)
    }
    
    func averageTimeOneHobby(for hobby: Hobby) -> Double {
        let totalTime = hobby.monthlyTime
        let currentDay = Calendar.current.component(.day, from: Date())
        
        guard currentDay > 0 else { return 0 }
        
        return totalTime / Double(currentDay)
    }
}
