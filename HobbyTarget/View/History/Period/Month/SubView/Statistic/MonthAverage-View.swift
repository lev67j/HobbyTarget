//
//  MonthStatisticView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 09.08.2024.
//

import SwiftUI

struct MonthAverageView: View {
  
    @ObservedObject var monthVM: MonthViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.horizontal)
            
            
            VStack {
                ForEach(monthVM.hobbies, id: \.id) { hobby in
                    MonthStatisticRowView(monthVM: monthVM, hobby: hobby)
                }
            }
            .padding()
        }
    }
}
