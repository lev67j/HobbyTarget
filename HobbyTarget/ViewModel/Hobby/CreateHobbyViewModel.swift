//
//  CreateHobbyViewModel.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.08.2024.
//

import SwiftUI

final class CreateHobbyViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var timeTarget = ""
    @Published var dateStart = Date()
    @Published var isFavourite = false
    @Published var notes = ""
    
}
