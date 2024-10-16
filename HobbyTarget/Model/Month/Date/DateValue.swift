//
//  DateValue.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 08.08.2024.
//

import SwiftUI

// Date Value Model
struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}

