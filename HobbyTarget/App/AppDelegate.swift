//
//  AppDelegate+.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 09.08.2024.
//

import SwiftUI
import UserNotifications
import CoreData
/*
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, ObservableObject {
    
    private var homeVM: HomeViewModel!
    /*
    var saveTimeHobby: TimeInterval = 0
    var isExitApplication: Bool = false
    */
    // MARK: - reset time hobby
    func application(_ application: UIApplication) -> Bool {
        
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
    
    
    // MARK: - save time hobby
    /*
    func applicationDidEnterBackground(_ application: UIApplication) {
        isExitApplication = true
        let currentTime = Date()
        UserDefaults.standard.set(currentTime, forKey: "lastCloseTime")
        print("applicationDidEnterBackground")
    }
    
    func applicationWillTerminate(_ application: UIApplication)  {
        isExitApplication = true
        let currentTime = Date()
        UserDefaults.standard.set(currentTime, forKey: "lastCloseTime")
        print("applicationWillTerminate")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if let lastCloseTime = UserDefaults.standard.object(forKey: "lastCloseTime") as? Date {
            DispatchQueue.main.async {
                self.saveTimeHobby = Date().timeIntervalSince(lastCloseTime)
            }
        }
        print("applicationWillEnterForeground")
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        if let lastCloseTime = UserDefaults.standard.object(forKey: "lastCloseTime") as? Date {
            DispatchQueue.main.async {
                self.saveTimeHobby = Date().timeIntervalSince(lastCloseTime)
            }
        }
        print("applicationDidFinishLaunching")
    }
    */
}
*/
