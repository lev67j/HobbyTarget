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
        content.title = "Сброс времени"
        content.body = "Параметр timeForToday был сброшен."
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReset", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error)")
            }
        }
    }
    
    
    private func setupDailyReset() {
        // Сброс параметра в полночь
        let calendar = Calendar.current
        let now = Date()
        
        // Получаем следующий день и время 00:00:00
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.day! += 1
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        // Создаем дату для следующего сброса
        let nextMidnight = calendar.date(from: components)!
        
        // Устанавливаем таймер на сброс
        timer = Timer(fire: nextMidnight, interval: 86400, repeats: true) { [weak self] _ in
            self?.resetTimeForToday()
        }
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
     func resetTimeForToday() {
        let fetchRequest: NSFetchRequest<Hobby> = Hobby.fetchRequest()
        
        do {
            let hobbies = try context.fetch(fetchRequest)
            for hobby in hobbies {
                // Сохраняем текущее значение timeForToday в новый параметр monthlyTime
                hobby.monthlyTime += hobby.timeForToday
                
                // Сбрасываем timeForToday
                hobby.timeForToday = 0
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
