//
//  ContentView.swift
//  Guess the flag
//
//  Created by Godwin IE on 15/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland" , "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
       
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
                                    Image(countries[number])
                                        .renderingMode(.original)
                                        .clipShape(Capsule())
                                        .shadow(radius: 5)
                                }
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Spacer()
                      //  Spacer()
                        
                        Text("Your score is \(score)")
                            .foregroundColor(.white)
                            .font(.body.bold())
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button ("Continue", action: askQuestion)
            } message: {
                Text ("Your score is \(score)")
            }
    }
    
    //function
    func flagTapped (_ number : Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
