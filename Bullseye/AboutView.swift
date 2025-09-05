//
//  AboutView.swift
//  Bullseye
//
//  Created by XIN on 9/5/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack{
            Text("🥳 Bullsye 🥳")
            Text("This is Bullseye, the game where you can win points and earn fame by dragging.")
            Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
            Text("Enjoy!")
        }
        .multilineTextAlignment(.center)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
