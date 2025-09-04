//
//  ContentView.swift
//  Bullseye
//
//  Created by XIN on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    //@State var whosThereVisible: Bool = false

    var body: some View {
        VStack {
            VStack {
                Spacer()
                //target row
                HStack {
                    Text("Put the bullseye as close as you can to:")
                    Text("100")
                        //.fontWeight(.semibold)
                        //.foregroundColor(Color.green)
                }
                Spacer()
                
             //Slider row
                HStack{
                    Text("1")
                    Slider(value:self.$sliderValue, in: 1...100)
                    Text("100")
                }
                
                //Button row
                Button(action: {
                    print("Button pressed!")
                    self.alertIsVisible = true
                }) {
                    Text("Hit Me!")
                }
                Spacer()
            }
            
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                var roundedValue: Int = Int(self.sliderValue.rounded())
                return Alert(title: Text("Hello there!"),
                             message: Text("The slider's value is \(roundedValue)"),
                             dismissButton: .default(Text("Awesome!")))
            }
            Spacer()
            
            //Score Row
            HStack{
                Button(action:{}) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score")
                Text("999999")
                Spacer()
                Text("Round")
                Text("999")
                Spacer()
                Button(action:{}) {
                    Text("Info")
                }
            }
            .padding(.bottom,20)
        }
        
        /*Button(action:{
            self.whosThereVisible = true
        }) {
            Text("Knock,Knock!")
        }
        .alert(isPresented: $whosThereVisible) { () -> Alert in
            return Alert(title: Text("Who's there?"),
                         message: Text("Little Old Lady."),
                         dismissButton: .default(Text("Little old lady who?")))
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
