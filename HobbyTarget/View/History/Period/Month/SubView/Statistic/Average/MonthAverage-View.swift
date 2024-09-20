//
//  MonthStatisticView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 09.08.2024.
//

import SwiftUI

struct MonthAverageView: View {
    
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
            
            
            VStack {
                ForEach(hobbies, id: \.id) { hobby in
                    VStack {
                        
                        HStack {
                            Text("\(hobby.name ?? "No Name")")
                                .bold()
                            
                            Spacer()
                            
                            Text(monthVM.formatTime(monthVM.averageTimeOneHobby(for: hobby)))
                                .bold()
                        }
                        .padding()
                    }
                }
            }
            .padding()
        }
    }
}
