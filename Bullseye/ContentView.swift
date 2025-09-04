//
//  ContentView.swift
//  Bullseye
//
//  Created by XIN on 9/4/25.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    //@State var whosThereVisible: Bool = false

    var body: some View {
        VStack {
            VStack {
                Spacer()
                //target row
                HStack {
                    Text("Put the bullseye as close as you can to:")
                    Text("\(target)")
                        //.fontWeight(.semibold)
                        //.foregroundColor(Color.green)
                }
                Spacer()
                
             //Slider row
                HStack{
                    Text("1")
                    Slider(value:$sliderValue, in: 1...100)
                    Text("100")
                }
                
                //Button row
                Button(action: {
                    print("Button pressed!")
                    alertIsVisible = true
                    self.score = self.score + self.pointsForCurrentRound()
                    self.target = Int.random(in: 1...100)
                }) {
                    Text("Hit Me!")
                }
                Spacer()
            }
            
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                //let roundedValue = Int(sliderValue.rounded())
                return Alert(title: Text("Hello there!"),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" +
                                           "You scored \(pointsForCurrentRound()) pints this round"
                                          ),
                             dismissButton: .default(Text("Awesome!")){
                    
                })
            }
            Spacer()
            
            //Score Row
            HStack{
                Button(action:{}) {
                    Text("Start Over")
                }
                Spacer()
                Text("Score")
                Text("\(score)")
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
    
    func sliderValueRounded()-> Int{
        return Int(sliderValue.rounded())
    }
    
    func pointsForCurrentRound()-> Int{
        return 100 - abs(target - sliderValueRounded())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
