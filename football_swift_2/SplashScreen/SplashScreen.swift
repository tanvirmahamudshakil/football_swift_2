//
//  splashScreen.swift
//  football_1
//
//  Created by Tanvir on 26/2/24.
//

import SwiftUI

struct splashScreen: View {
    var body: some View {
        ZStack{
            Image("live-tv").resizable().scaledToFill().frame(width: 100, height: 100)
        }
    }
}

#Preview {
    splashScreen()
}
