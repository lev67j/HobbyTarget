//
//  HobbyTargetApp.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.08.2024.
//

import SwiftUI
import UserNotifications

@main
struct HobbyTargetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
              
                HomeView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                
                HistoryView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .tabItem {
                        Image(systemName: "calendar.badge.clock")
                        Text("History")
                    }
            }
        }
    }
}

