//
//  HomeBackground.swift
//  HobbyTarget
//
//  Created by Lev Vlasov on 07.09.2024.
//

import SwiftUI

struct HomeBackground: View {
    var body: some View {
        Image("back")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HomeBackground()
}
