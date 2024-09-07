//
//  DayView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

struct DayView: View {

    // View Model
   @ObservedObject var monthVM: MonthViewModel
   
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.horizontal)
            
            
            VStack {
                ForEach(monthVM.hobbies, id: \.id) { hobby in
                    DayHobbyRowView(hobby: hobby)
                        
                    if monthVM.hobbies.endIndex < monthVM.hobbies.count - 1 || monthVM.hobbies.count > 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
            .padding()
        }
    }
}
