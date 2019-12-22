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
    
    @State var score: Int = 1
    
    @State var round: Int = 1
    
    @State var amountToGuess : Int = 50

    
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
                let ourValue: Int = abs(self.amountToGuess - Int(self.sliderValue))

                if ourValue == 0 {
                    self.score += 100
                } else if ourValue <= 1 {
                    self.score += 50
                } else if ourValue <= 10 {
                    self.score += ourValue
                }
                print(self.amountToGuess)
                print(Int(self.sliderValue))
                self.round+=1
            }) {
                Text("Check result!")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("You scored: "), message: Text("\(Int(sliderValue))"), dismissButton: .cancel())
            }
            
            Spacer()
            
            HStack{
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
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
