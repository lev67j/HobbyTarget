//
//  MonthStatisticRowView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 10.08.2024.
//

import SwiftUI

struct MonthStatisticRowView: View {
    
    // View Model
    @ObservedObject var monthVM: MonthViewModel
    
    // Hobby
    var hobby: Hobby
    
    var body: some View {
        VStack {
            
            HStack {
                Text("\(hobby.name ?? "No Name")")
                    .bold()
                
                Spacer()
                
             //   Text("\(periodVM.formatTime(hobby.monthlyTime))")
                Text(monthVM.formatTime(monthVM.averageTimeOneHobby(for: hobby)))
                    .bold()
            }
            .padding()
            
        }
    }
}

