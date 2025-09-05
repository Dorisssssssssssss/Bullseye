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
    @State var currentRoundTarget = 0
    let midnightBlue = Color(red: 0.0/255.0, green: 51/255.0, blue: 102/255.0)
    struct LabelStyle: ViewModifier{
        func body(content:Content)-> some View{
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold",size:30))
        }
    }
    struct ValueStyle: ViewModifier{
        func body(content:Content)-> some View{
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold",size:30))
        }
    }
    struct ShadowStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color:Color.black, radius:5,x:2,y:2)
        }
    }
    struct ButtonLargeTextStyle: ViewModifier {
            func body(content: Content) -> some View {
                return content
                    .foregroundColor(Color.black)
                    .font(Font.custom("Arial Rounded MT Bold", size: 18))
            }
        }
        
        struct ButtonSmallTextStyle: ViewModifier {
            func body(content: Content) -> some View {
                return content
                    .foregroundColor(Color.black)
                    .font(Font.custom("Arial Rounded MT Bold", size: 12))
            }
        }
    //@State var whosThereVisible: Bool = false

    var body: some View {
        VStack {
            VStack {
                Spacer()
                //target row
                HStack {
                    Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                    Text("\(target)").modifier(ValueStyle())
                        //.fontWeight(.semibold)
                        //.foregroundColor(Color.green)
                }
                Spacer()
                
             //Slider row
                HStack{
                    Text("1").modifier(LabelStyle())
                    Slider(value:$sliderValue, in: 1...100)
                    Text("100").modifier(LabelStyle())
                }
                Spacer()
                //Button row
                Button(action: {
                    print("Button pressed!")
                    // 先保存当前轮的目标值
                    self.currentRoundTarget = self.target
                    // 然后计算当前轮分数
                    self.currentRoundPoints = self.pointsForCurrentRound()
                    self.score = self.score + self.currentRoundPoints
                    // 然后显示alert
                    alertIsVisible = true
                    // 最后更新target和round
                    self.target = Int.random(in: 1...100)
                    self.round = self.round + 1
                }) {
                    Text("Hit Me!").modifier(ButtonLargeTextStyle())
                }
                .background(Image("Button")).modifier(ShadowStyle())
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
                Button(action:{
                    self.startNewGame()
                }) {
                    HStack{
                        Image("StartOverIcon")
                    }
                    Text("Start Over").modifier(ButtonSmallTextStyle())
                }
                .background(Image("Button")).modifier(ShadowStyle())
                .accentColor(midnightBlue)
                Spacer()
                Text("Score").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                Button(action:{}) {
                    HStack{
                        Image("InfoIcon")
                    }
                    Text("Info").modifier(ButtonSmallTextStyle())
                }.background(Image("Button")).modifier(ShadowStyle())
                
            }
            .padding(.bottom,20)
        }
        .background(Image("Background"),alignment: .center)
        .accentColor(midnightBlue)
        .onAppear {
            currentRoundTarget = target
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
        abs(currentRoundTarget - sliderValueRounded())
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
        let difference = abs(currentRoundTarget - sliderValueRounded())
        print("Debug: currentRoundTarget = \(currentRoundTarget), sliderValue = \(sliderValue), sliderValueRounded = \(sliderValueRounded()), difference = \(difference)")
        let title: String
        if difference == 0{
            title = "Perfect"
        }else if difference <= 5{
            title = "You almost had it!"
        }else if difference <= 10{
            title = "Not bad."
        }else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame(){
        score = 0
        round = 1
        sliderValue = 50.0
        target = Int.random(in:1...100)
        currentRoundTarget = target
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14 Pro")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
