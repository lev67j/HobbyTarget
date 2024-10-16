//
//  RestTime.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 11.09.2024.
//

import SwiftUI

struct RestTime: View {

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
                
                HStack {
                    Text("Rest of the time")
                        .bold()
                        .padding()
                    
                    Spacer()
                    
                    Text(monthVM.averageRestTime(hobbies: hobbies))  
                        .bold()
                        .padding()
                }
                .padding()
                
            }
        }
    }
}

