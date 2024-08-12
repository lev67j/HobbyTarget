//
//  MonthStatisticView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 09.08.2024.
//

import SwiftUI

struct HobbyMetaData: Identifiable {
    var id = UUID().uuidString
    var hobbies: [FetchedResults<Hobby>]
    var hobbyDate: Date
}

func getSampleDate(offset: Int) -> Date {
    
    let calendar = Calendar.current
    
    // Getting Current Month Date...
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

struct MonthStatisticView: View {
    
    // Core Data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)],
        animation: .default)
    private var hobbies: FetchedResults<Hobby>
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 8))
                .padding(.horizontal)
            
            
            VStack {
                ForEach(hobbies, id: \.id) { hobby in
                    MonthStatisticRowView(hobby: hobby)
                }
            }
            .padding()
        }
    }
}
