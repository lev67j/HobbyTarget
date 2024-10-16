//
//  DayView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

struct DayView: View {
    
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)],
        animation: .default)
    
    private var hobbies: FetchedResults<Hobby>
    
    // View Model
    @ObservedObject var monthVM: MonthViewModel
    @ObservedObject var periodVM = PeriodStateViewModel()

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
            
            
            VStack {
                ForEach(hobbies, id: \.id) { hobby in
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
                    
                    if hobbies.endIndex < hobbies.count - 1 || hobbies.count > 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
            .padding()
        }
    }
}
