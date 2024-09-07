//
//  CircleTimePerDay.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 06.09.2024.
//

import SwiftUI

struct CircleTimePerDay: View {
    
    // View Model
    @ObservedObject var monthVM: MonthViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.horizontal)
            
            VStack(spacing: 5) {
                
                Spacer()
                
                // Current Month
                Text(monthVM.currentMonth())
                    .font(.title3.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                
                ZStack {
                    
                    Circle()
                        .stroke(Color.blue.opacity(0.3), lineWidth: 6)
                        .frame(width: 200, height: 200)
                    
                    
                    Text(monthVM.formatTime(monthVM.averageTimePerDay()))
                        .font(.title2.bold())
                }
            }
            .padding()
        }
    }
}
