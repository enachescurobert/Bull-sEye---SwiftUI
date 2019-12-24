//
//  ContentView.swift
//  Bullseye
//
//  Created by Robert Enachescu on 22/12/2019.
//  Copyright © 2019 Enachescu Robert. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    
    @State var alertShouldBeVisibleForKnock: Bool = false
    
    @State var sliderValue: Double = 50
    
    @State var score: Int = 0
    
    @State var round: Int = 1
    
    @State var amountToGuess : Int = Int.random(in: 1 ... 100)

    struct LabelStyle: ViewModifier {
       func body(content: Content) -> some View {
         return content
           .foregroundColor(Color.white)
           .modifier(Shadow())
           .font(Font.custom("Arial Rounded MT Bold", size: 18))
       }
     }
    
     struct ValueStyle: ViewModifier {
       func body(content: Content) -> some View {
         return content
           .foregroundColor(Color.yellow)
           .modifier(Shadow())
           .font(Font.custom("Arial Rounded MT Bold", size: 24))
       }
     }
     
     struct Shadow: ViewModifier {
       func body(content: Content) -> some View {
         return content
           .shadow(color: Color.black, radius: 5, x: 2, y: 2)
       }
     }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())

                Text("\(amountToGuess)")
                    .modifier(ValueStyle())
            }
            
            Spacer()
            HStack {
                Spacer()
                Text("1")
                    .modifier(ValueStyle())
                Slider(value: $sliderValue, in: 1...100, step: 1)
                Text("100")
                    .modifier(ValueStyle())
                Spacer()
            }
            
            Spacer()
            Button(action: {
                print("button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Check result!")
                    .padding(.trailing, 28.0)
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                
                let ourValue: Int = abs(amountToGuess - Int(sliderValue))
                var pointsToGet: Int = 0
                
                print(amountToGuess)
                print(Int(sliderValue))

                switch ourValue {
                case 0:
                    pointsToGet = 100
                    print("You gain \(pointsToGet) points")
                case 1:
                    pointsToGet = 50
                    print("You gain \(pointsToGet) points")
                case 2...10:
                    pointsToGet = 20 - ourValue
                    print("You gain \(pointsToGet) points")
                default:
                    print("You gain 0 points for having the difference as \(ourValue)")
                }
                
                return Alert(title: Text("Your result: \(Int(sliderValue))"), message: Text("You get : \(pointsToGet) points"), dismissButton: .cancel({
            
                    self.score += pointsToGet
                    self.round+=1
                    self.amountToGuess = Int.random(in: 0 ... 100)
                    
                }))
            }
            
            Spacer()
            
            HStack{
                Button(action: {
                    self.amountToGuess = Int.random(in: 0 ... 100)
                    self.round = 0
                    self.score = 0
                }) {
                    Text("Start over")
                }
                Spacer()
                HStack{
                    Text("Score:")
                        .modifier(LabelStyle())
                    Text("\(score)")
                        .modifier(ValueStyle())
                }
                Spacer()
                HStack{
                    Text("Round:")
                        .modifier(LabelStyle())
                    Text("\(round)")
                        .modifier(ValueStyle())
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }.padding(.all, 20)
                    
        }
        .background(Color(red: 0.29, green: 0.15, blue: 0.0, opacity: 1.0))
//        .background(Image("Background"), alignment: .center)
    }


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().previewLayout(.fixed(width: 896, height: 414))
        }
    }
}
