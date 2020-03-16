//
//  ContentView.swift
//  LearningSwiftUI
//
//  Created by Kynan Song on 06/03/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert = false
    
    @ObservedObject var timer = TimerCounter()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack{
                        
                        Rectangle().foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                        self.showAlert ? Text("R: \(Int(rTarget * 255.0))" + " G:\(Int(gTarget * 255.0))" + " B:\(Int(bTarget * 255.0))").font(.system(size: 15)) : Text("Match this colour").font(.system(size: 15))
                    }
                    
                    VStack {
                        ZStack(alignment: .center) {
                           Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0)
                            Text(String(timer.counter))
                            .padding(.all, 5)
                            .background(Color.white)
                            .mask(Circle())
                            .foregroundColor(.black)
                        }
                        
                        HStack {
                            Text("R: \(Int(rGuess * 255.0))").font(.system(size: 15))
                            Text("G: \(Int(gGuess * 255.0))").font(.system(size: 15))
                            Text("B: \(Int(bGuess * 255.0))").font(.system(size: 15))
                        }
                    }
                }
                
                Button(action: {
                    self.showAlert = true
                    self.timer.killTimer()
                }) {
                    Text("Hit me")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Your Score"), message: Text("\(computeScore())"), dismissButton: .cancel())
                }.padding()
                
                VStack {
                    ColourSlider(value: $rGuess, textColour: .red)
                    ColourSlider(value: $gGuess, textColour: .green)
                    ColourSlider(value: $bGuess, textColour: .blue)
                }
                
                
                NavigationLink(destination: ViewControllerRepresentation()) {
                    Text("Play BullsEye")
                }.padding(.bottom)
            }
        }
    }
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            .previewLayout(.fixed(width: 568, height: 320))
    }
}

struct ColourSlider: View {
    @Binding var value: Double
    var textColour: UIColor
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(Color(textColour))
//            Slider(value: $value)
//                .background(textColour)
//                .cornerRadius(10)
            ColourUISlider(colour: textColour, value: $value)
            Text("255").foregroundColor(Color(textColour))
        }
        .padding(.horizontal)
    }
}
