//
//  HobbyTargetApp.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.08.2024.
//

import SwiftUI

@main
struct HobbyTargetApp: App {
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
                
                
            }
        }
    }
}
