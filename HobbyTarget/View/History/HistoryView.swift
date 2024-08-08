//
//  HistoryView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//
/*
import SwiftUI
import CoreData

struct HistoryView: View {
    // Core Data
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedDate: Date = Date()

    // Используем @FetchRequest с NSPredicate для фильтрации по дате
    @FetchRequest(
        entity: Hobby.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Hobby.name, ascending: false)],
        predicate: nil, // Начально без предиката
        animation: .default)
    private var hobbies: FetchedResults<Hobby>
    
    var filteredHobbies: [Hobby] {
       // Фильтруем хобби по выбранной дате
        hobbies.filter { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: selectedDate) }
    }

    var body: some View {
        NavigationView {
            VStack {
                DatePicker("Выберите дату", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .onChange(of: selectedDate) { newValue in
                        // Обновляем предикат при изменении даты
                        updateFetchRequest(for: newValue)
                    }

                List {
                    ForEach(filteredHobbies, id: \.self) { hobby in
                        HStack {
                            Text(hobby.name ?? "Unknown")
                            Spacer()
                            Text(formatTime(hobby.timeForToday))
                        }
                    }
                }
            }
            .navigationTitle("История хобби")
        }
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = (Int(time) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }

    private func updateFetchRequest(for date: Date) {
        // Создание предиката для фильтрации по выбранной дате
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!

        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        hobbies.nsPredicate = predicate
    }
}

#Preview {
    HistoryView()
}

*/
