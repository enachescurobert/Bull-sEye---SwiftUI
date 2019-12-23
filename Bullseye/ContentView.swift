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
    
    @State var amountToGuess : Int = Int.random(in: 0 ... 100)

    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                
                Text("\(amountToGuess)")
            }
            
            Spacer()

            
            
            HStack {
                
                Text("1")
                
                Slider(value: self.$sliderValue, in: 1...100, step: 1)

                Text("100")

            }
            
            Spacer()
        
            Button(action: {
                print("button pressed!")
                self.alertIsVisible = true

            }) {
                Text("Check result!")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                
                let ourValue: Int = abs(self.amountToGuess - Int(self.sliderValue))
                var pointsToGet: Int = 0
                
                print(self.amountToGuess)
                print(Int(self.sliderValue))

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
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round")
                Text("\(round)")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }.padding(.bottom, 20)
        
        }
    }


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().previewLayout(.fixed(width: 896, height: 414))
        }
    }
}
