//
//  ContentView.swift
//  Bullseye
//
//  Created by XIN on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible: Bool = false

    var body: some View {
        VStack {
            Text("Welcome to my first app!")
                .fontWeight(.semibold)
                .foregroundColor(Color.green)
            Button(action: {
                print("Button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit Me!")
            }
        }
        .alert(isPresented: $alertIsVisible) { () -> Alert in
            return Alert(title: Text("Hello there!"),
                         message: Text("This is my first pop-up."),
                         dismissButton: .default(Text("Awesome!")))
        }
    }
}

#Preview {
    ContentView()
}
