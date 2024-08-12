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
    @State private var selectedPeriod: Period = .day
    @State private var selectedDate: Date = Date()
    
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
                            MonthView()
                        case .week:
                            WeekView() //(hobby: hobby)
                        case .day:
                            DayView() //(hobby: hobby)
                    }
                }
                .navigationTitle("History")
            }
        }
    }
}
