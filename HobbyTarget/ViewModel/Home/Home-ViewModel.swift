//
//  HomeViewModel.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.08.2024.
//

import UserNotifications
import Foundation
import CoreData

final class HomeViewModel: ObservableObject {
    
    @Published var showCreateHobby = false
    private var timer: Timer?
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        setupDailyReset()
        scheduleDailyResetNotification()
    }
    

    private func scheduleDailyResetNotification() {
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = ""
        content.sound = nil

        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReset", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error add notify: \(error)")
            }
        }
    }
    
    
    private func setupDailyReset() {
        // Reset
        let calendar = Calendar.current
        let now = Date()
        
        // Get next day and time - 00:00:00
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.day! += 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        // Cerate date for next reset
        let nextMidnight = calendar.date(from: components)!
        
        // Timer for reset
        let today = Date()
        timer = Timer(fire: nextMidnight, interval: 86400, repeats: true) { [weak self] _ in
            self?.resetTimeForToday(for: today)
        }
        // Add timer in Run Time
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func resetTimeForToday(for date: Date) {
        let fetchRequest: NSFetchRequest<Hobby> = Hobby.fetchRequest()
        
        do {
            let hobbies = try context.fetch(fetchRequest)
            for hobby in hobbies {
                
                // Save timeForToday in monthlyTime
                hobby.monthlyTime += hobby.timeForToday
                
                // Reset timeForToday
                hobby.timeForToday = 0
                
                // Check save monthlyTime and date
                print("Check monthlyTime: \(hobby.monthlyTime)")
            }
            try context.save()
        } catch {
            print("Failed to reset timeForToday: \(error)")
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
