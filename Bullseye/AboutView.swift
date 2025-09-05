//
//  AboutView.swift
//  Bullseye
//
//  Created by XIN on 9/5/25.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red:255.0/255.0,green:214.0/255.0,blue:179.0/255.0)
    
    struct AboutHeadingStyle: ViewModifier{
        func body(content:Content)-> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold",size:30))
                .padding(.top, 30)
                .padding(.bottom, 1)
        }
    }
    struct AboutBodyStyle: ViewModifier{
        func body(content:Content)-> some View{
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold",size:20))
                .padding(.top, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 10)
        }
    }
    var body: some View {
        NavigationStack {
                    Group {
                        VStack {
                            Text("🎯 Bullseye 🎯").modifier(AboutHeadingStyle())
                            Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.").modifier(AboutBodyStyle())
                            Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(AboutBodyStyle())
                            Text("Enjoy!").modifier(AboutBodyStyle())
                        }.background(beige)
                    }.background(Image("Background"))
                }
        .multilineTextAlignment(.center)
        .navigationTitle("About Bullseye")
        .toolbarBackground(Color.white.opacity(0.5), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(beige)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
