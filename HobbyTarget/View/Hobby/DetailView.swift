//
//  DetailView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

struct DetailView: View {
    var hobby: Hobby 
    
    var body: some View {
        Form {
            Section {
                Text("Name: \(hobby.name ?? "Unknown")")
                
                Text("Time Target: \(hobby.timeTarget ?? "Not specified")")
                
                Text("Favourite: \(hobby.isFavourite ? "Yes" : "No")")
                
                Text("Start Date: \(formatDate(hobby.dateStart ?? .now))")
                
                Text("Time For Today: \(formatTime(hobby.timeForToday))")
            }
            
            Section("Notes") {
                Text("\(hobby.notes ?? "")")
            }
        }
        .navigationTitle("Hobby Details")
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
    }
        
    // Formats
    private func formatDate(_ date: Date) -> String {
        // Format the date as needed
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func formatTime(_ time: TimeInterval) -> String {
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
}
