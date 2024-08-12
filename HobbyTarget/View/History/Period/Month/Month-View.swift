//
//  MonthView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

struct MonthView: View {
  
    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            VStack(spacing: 20) {
                // Month Picker
                MonthPickerView(currentDate: $currentDate)
            }
        }
    }
}

