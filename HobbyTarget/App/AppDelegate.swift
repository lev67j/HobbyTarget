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
         
        // Request permission for notify
        requestNotificationPermission()
        
        // Let's plan "silent" notify
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
        
        // Create content notify
        let content = UNMutableNotificationContent()
        content.title = ""
        content.body = ""
        content.sound = nil
        
        // Settings time notify - 00:00
        var dateComponents = DateComponents()
        dateComponents.hour = 0
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create request for notify
        let request = UNNotificationRequest(identifier: "dailyReset", content: content, trigger: trigger)
        
        // Add request in Notification Center
        center.add(request) { error in
            if let error = error {
                print("Error adding notification: \(error)")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "dailyReset" {
            // reset
            let today = Date()
            homeVM.resetTimeForToday(for: today)
        }
        completionHandler()
    }
}
