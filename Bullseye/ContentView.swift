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
    @State var round = 1
    @State var currentRoundPoints = 0
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
                    // 先计算当前轮分数
                    self.currentRoundPoints = self.pointsForCurrentRound()
                    self.score = self.score + self.currentRoundPoints
                    // 然后显示alert
                    alertIsVisible = true
                    // 最后更新target和round
                    self.target = Int.random(in: 1...100)
                    self.round = self.round + 1
                }) {
                    Text("Hit Me!")
                }
                Spacer()
            }
            
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                //let roundedValue = Int(sliderValue.rounded())
                return Alert(title: Text(alertTitle()),
                             message: Text("The slider's value is \(sliderValueRounded()).\n" +
                                           "You scored \(currentRoundPoints) points this round"
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
                Text("\(round)")
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
    
    func amountOff() -> Int{
        abs(target - sliderValueRounded())
    }
    
    func pointsForCurrentRound()-> Int{
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        if difference == 0{
            bonus = 100
        }else if difference == 1{
            bonus = 50
        }else{
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    func alertTitle() -> String {
        let difference = abs(target - sliderValueRounded())
        let title: String
        if difference == 0{
            title = "Perfect"
        }else if difference <= 5{
            title = "You almost had it!"
        }else if difference <= 10{
            title = "Not bac."
        }else {
            title = "Are you even trying?"
        }
        return title
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
