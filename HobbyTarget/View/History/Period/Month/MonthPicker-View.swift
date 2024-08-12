//
//  MonthPicker.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI
import Foundation


struct MonthPickerView: View {
    
    // Core Data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: true)],
        animation: .default)
    private var hobbies: FetchedResults<Hobby>
    
    
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    @Binding var currentDate: Date
    
    var body: some View {
        VStack(spacing: 35) {
            
            // Days...
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            
            // Day View...
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            
            // Dates...
            
            // Lazy Grid...
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns) {
                
                ForEach(extractDate()) { value in
                    cardView(value: value)
                        .background(
                        
                        Capsule()
                            .fill(.pink.opacity(0.6))
                            .padding(.horizontal, 8)
                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            VStack {
                Text("Hobby Statistic")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if let hobby = hobbies.first(where: { hobby in
                    return isSameDay(date1: hobby.dateForState ?? .now, date2: currentDate)
                }) {
                    // Monthly Statistic
                    MonthStatisticView()
                } else {
                    // Empty Monthly Statistic
                    EmptyMonthStatisticView()
                }
            }
        }
        .onChange(of: currentMonth) { oldValue, newValue in
            
            // updating Month...
            currentDate = getCurrentMonth()
            
        }
    }

    @ViewBuilder
    func cardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                
                if let hobby = hobbies.first(where: { hobby in
                    
                    return isSameDay(date1: hobby.dateForState ?? .now, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .foregroundStyle(isSameDay(date1: hobby.dateForState ?? .now, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: hobby.dateForState ?? .now, date2: currentDate) ? .white : .pink)
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(value.day)")
                        .foregroundStyle(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 5)
        .frame(height: 50, alignment: .top)
    }
    
    // checking dates...
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
     
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // extrating Year And Month for display...
    func extraDate() -> [String] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
        // Getting Current Month Date...
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            // getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

