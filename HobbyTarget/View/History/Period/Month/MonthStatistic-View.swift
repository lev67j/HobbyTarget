//
//  MonthPicker.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI
import CoreData


struct MonthStatisticView: View {
  
    // View Model
   @ObservedObject var monthVM: MonthViewModel
      
    var body: some View {
        VStack(spacing: 35) {
            
            VStack {
                Text("Average time per day")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                CircleTimePerDay(monthVM: monthVM)
            }
            
            VStack {
                Text("Average time hobby")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                // Average time for one hobby
                MonthAverageView(monthVM: monthVM)
            }
        }
    }
    
}