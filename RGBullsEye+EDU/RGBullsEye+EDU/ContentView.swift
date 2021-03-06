//
//  ContentView.swift
//  RGBullsEye
//
//  Created by Eric Golovin on 23.07.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var rTarget = Double.random(in: 0..<1)
    @State private var gTarget = Double.random(in: 0..<1)
    @State private var bTarget = Double.random(in: 0..<1)
    @State private var rGuess = 0.5
    @State private var gGuess = 0.5
    @State private var bGuess = 0.5
    
    @State private var showAlert = false
    
    @ObservedObject var timer = TimeCounter()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget).cornerRadius(10.0)
                        self.showAlert ? Text("R: \(Int(rTarget * 255.0)) G: \(Int(gTarget * 255.0)) B: \(Int(bTarget * 255.0))") : Text("Match this color")
                    }
                    VStack {
                        ZStack(alignment: .center) {
                            Color(red: rGuess, green: gGuess, blue: bGuess).cornerRadius(10.0)
                            Text("\(timer.counter)")
                                .padding(.all, 5)
                                .background(Color.white)
                                .mask(Circle())
                                .foregroundColor(.black)
                        }
                        Text("R: \(Int(rGuess * 255.0)) G: \(Int(gGuess * 255.0)) B: \(Int(bGuess * 255.0))")
                    }
                }.padding(.bottom)
                
                Button(action: {
                    self.showAlert = true
                    self.timer.killTimer()
                }) {
                    Text("Hit Me!").fontWeight(.bold).font(.title)
                }.alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Your Score"), message: Text(String(computeScore()) + " / 100"), primaryButton: .default(Text("New color"), action: {
                        self.rTarget = Double.random(in: 0..<1)
                        self.gTarget = Double.random(in: 0..<1)
                        self.bTarget = Double.random(in: 0..<1)
                        self.rGuess = 0.5
                        self.gGuess = 0.5
                        self.bGuess = 0.5
                        self.timer.startNewTimer()
                    }), secondaryButton: .cancel(Text("Cancel")))
                }).padding()
                
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $gGuess, textColor: .green)
                    ColorSlider(value: $bGuess, textColor: .blue)
                }.padding(.horizontal)
                NavigationLink(
                destination: ViewControllerRepresentation()) {
                    Text("Play BullsEye")
                }.padding(.top)
            }.padding().navigationBarTitle(Text("Game"), displayMode: .inline)
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
        ContentView()
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: UIColor
    var body: some View {
        HStack {
            Text("0").foregroundColor(Color(textColor))
            ColorUISlider(color: textColor, value: $value)
            Text("255").foregroundColor(Color(textColor))
        }
    }
}
