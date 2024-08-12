//
//  DetailHistoryView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

struct DetailHistoryView: View {
    var date: Date

    var body: some View {
        VStack {
            Text("Записи на \(date, formatter: dateFormatter)")
                .font(.largeTitle)
                .padding()
            // Здесь вы можете добавить логику для отображения записей
        }
        .navigationTitle("Детали")
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
