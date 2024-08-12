//
//  AppDelegate+.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 09.08.2024.
//


import SwiftUI
import UserNotifications
import CoreData

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    private var homeVM: HomeViewModel!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
        // Запрашиваем разрешение на уведомления
        requestNotificationPermission()
        
        // Запланируем "тихое" уведомление
        scheduleSilentNotification()
        return true
    }
    
    private func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error)")
            }
        }
    }
    
    private func scheduleSilentNotification() {
        let center = UNUserNotificationCenter.current()
        
        // Создание содержимого уведомления
        let content = UNMutableNotificationContent()
        content.title = "" // Не отображается
        content.body = "" // Не отображается
        content.sound = nil // Без звука
        
        // Настройка времени уведомления (например, каждый день в 00:00)
        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Создание запроса на уведомление
        let request = UNNotificationRequest(identifier: "dailyReset", content: content, trigger: trigger)
        
        // Добавление запроса в центр уведомлений
        center.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "dailyReset" {
            // Здесь вы можете получить доступ к вашему контексту и сбросить timeForToday
            homeVM.resetTimeForToday()
        }
        completionHandler()
    }
}
