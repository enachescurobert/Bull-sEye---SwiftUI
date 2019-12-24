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
    
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)

    struct LabelStyle: ViewModifier {
       func body(content: Content) -> some View {
         return content
           .foregroundColor(Color.white)
           .modifier(Shadow())
           .font(Font.custom("Arial Rounded MT Bold", size: 18))
       }
     }
    
    struct ButtonLargeTextStyle: ViewModifier {
       func body(content: Content) -> some View {
         return content
           .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .padding(/*@START_MENU_TOKEN@*/.trailing, 34.0/*@END_MENU_TOKEN@*/)
       }
     }
    
    struct ButtonSmallTextStyle: ViewModifier {
       func body(content: Content) -> some View {
         return content
           .foregroundColor(Color.black)
           .font(Font.custom("Arial Rounded MT Bold", size: 12))
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
                    .accentColor(Color.green)
                Text("100")
                    .modifier(ValueStyle())
                Spacer()
            }
            
            Spacer()
            Button(action: {
                print("button pressed!")
                self.alertIsVisible = true
            }) {
                Text("Hit me!").modifier(ButtonLargeTextStyle())
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
            }.background(Image("Button")
                .padding(.trailing, 34.0)).modifier(Shadow())

            
            Spacer()
            
            HStack{
                Button(action: {
                    self.amountToGuess = Int.random(in: 0 ... 100)
                    self.round = 0
                    self.score = 0
                }) {
                    HStack{
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
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
//                NavigationLink(destination: AboutView, label: "PLM") {
//                Button(action:{}){
                NavigationLink(destination: AboutView()){
                    HStack{
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(Shadow())
            }.padding(.horizontal, CGFloat(58.0))
               Spacer()
            }.accentColor(midnightBlue)
//        .background(Color(red: 0.20, green: 0.12, blue: 0.0, opacity: 1.0))
        .navigationBarTitle("Bullseye")
        .background(Image("Background"), alignment: .center)
    }


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().previewLayout(.fixed(width: 896, height: 414))
        }
    }
}
