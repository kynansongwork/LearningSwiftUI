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
    
    var body: some View {
        VStack {
            HStack {
                VStack{
                    
                    Rectangle().foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget, opacity: 1.0))
                    Text("Match this colour").font(.system(size: 15))
                }
                
                VStack {
                    
                    Rectangle().foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess, opacity: 1.0))
                    
                    HStack {
                        Text("R: \(Int(rGuess * 255.0))").font(.system(size: 15))
                        Text("G: \(Int(gGuess * 255.0))").font(.system(size: 15))
                        Text("B: \(Int(bGuess * 255.0))").font(.system(size: 15))
                    }
                }
            }
            
            Button(action: {
                self.showAlert = true
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
    }
}

struct ColourSlider: View {
    @Binding var value: Double
    var textColour: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColour)
            Slider(value: $value)
            Text("255").foregroundColor(textColour)
        }
        .padding()
    }
}
