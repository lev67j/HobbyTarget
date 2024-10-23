//
//  PeriodStateViewModel.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 10.08.2024.
//

import Foundation

final class PeriodStateViewModel: ObservableObject {
    
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
}
