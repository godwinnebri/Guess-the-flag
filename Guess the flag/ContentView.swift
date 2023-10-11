//
//  ContentView.swift
//  Guess the flag
//
//  Created by Godwin IE on 15/09/2023.
//

import SwiftUI

struct FlagImage: View {
    var country : String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var userSelection = 0
    @State private var attempts = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland" , "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var yAxis = 0.0
       
        var body: some View {
            GeometryReader{ geometry in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                    Image("wp")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                    
                    
                    VStack{
                        Spacer()
                        Text("Guess the flag")
                            .foregroundColor(.white)
                            .font(.largeTitle.bold())
                        
                        VStack (spacing: 15) {
                            VStack (spacing: 4) {
                                Text("Tap the flag of")
                                    .foregroundColor(.white)
                                    .font(.subheadline.weight(.semibold))
                                Text(countries[correctAnswer])
                                    .foregroundColor(.white)
                                    .font(.largeTitle.weight(.heavy))
                            }
                            
                            ForEach (0..<3) { number in
                                Button {
                                    flagTapped(number)
                                } label: {
                                    FlagImage(country: countries[number])
                                }
                                .rotation3DEffect(.degrees(number == userSelection ? yAxis : 0), axis: (x: 0, y: 1, z: 0))

                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Spacer()
                      //  Spacer()
                        
                        VStack (spacing: 14) {
                            Text("Your score is \(score)")
                                .foregroundColor(.white)
                                .font(.body.bold())
                            
                            
                            Text("Attempts: \(attempts)/8")
                                .foregroundColor(.white)
                                .font(.body.bold())
                        }
                            
                        Spacer()
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button (attempts != 8 ? "Continue" : "Restart",
                        action: attempts != 8 ? askQuestion : reset)
              
               
            } message: {
                Text ("Your score is \(score)/8")
            }
    }
    
    //function
    func flagTapped (_ number : Int) {
        userSelection = number
            if number == correctAnswer {
                scoreTitle = attempts != 7 ? "Correct" : "🚀 GAME OVER"
                score += 1
                attempts += 1
            } else {
                scoreTitle = attempts != 7 ? "Wrong, that's the flag of \(countries[number])" : "🚀 GAME OVER"
                attempts += 1
            }
        
        withAnimation{
            yAxis += 360.0
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        attempts = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
