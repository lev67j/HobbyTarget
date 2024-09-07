//
//  MonthView.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

struct MonthView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    // View Model
    @ObservedObject var monthVM: MonthViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:  false) {
            VStack(spacing: 20) {
                // Month Picker
                MonthStatisticView(monthVM: monthVM)
            }
        }
    }
}

