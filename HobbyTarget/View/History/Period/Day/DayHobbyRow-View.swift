//
//  DayHobbyRowView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 10.08.2024.
//

import SwiftUI

struct DayHobbyRowView: View {
    
    // View Model
    @ObservedObject var periodVM = PeriodStateViewModel()
   
    // Hobby
    var hobby: Hobby
  
    var body: some View {
        VStack {
            
            HStack {
                Text("\(hobby.name ?? "No Name")")
                    .bold()
                
                Spacer()
                
                Text("\(periodVM.formatTime(hobby.timeForToday))")
                    .bold()
            }
            .padding()
            
        }
    }
}

