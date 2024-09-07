//
//  HistoryView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI
import CoreData


struct HistoryView: View {
    
    // Periods and date
    @State private var selectedPeriod: Period = .month
    @State private var selectedDate: Date = Date()
    
    // View Model
    @StateObject var monthVM: MonthViewModel
    
    init() {
        _monthVM = StateObject(wrappedValue: MonthViewModel(context: PersistenceController.shared.container.viewContext))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Period", selection: $selectedPeriod) {
                    ForEach(Period.allCases, id: \.self) { period in
                        Text(period.rawValue.capitalized).tag(period)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ScrollView {
                        switch selectedPeriod {
                        case .month:
                            MonthView(monthVM: monthVM)
                        case .day:
                            DayView(monthVM: monthVM)
                          }
                }
                .navigationTitle("Statistic")
            }
        }
    }
}
