//
//  CircleTimePerDay.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 06.09.2024.
//

import SwiftUI

struct CircleTimePerDay: View {
   
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)],
        animation: .default)
    private var hobbies: FetchedResults<Hobby>
    
    // View Model
    @ObservedObject var monthVM: MonthViewModel
   
    init() {
        let context = PersistenceController.shared.container.viewContext
        _monthVM = ObservedObject(wrappedValue: MonthViewModel(context: context))
    }
    
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
                    
                    
                    Text(monthVM.formatTime(monthVM.averageTimePerDay(hobbies: hobbies)))
                        .font(.title2.bold())
                }
            }
            .padding()
        }
    }
    
   
}
