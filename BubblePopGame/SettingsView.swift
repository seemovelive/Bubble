//
//  SettingsView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

let settingBackgroundGradient = LinearGradient(
    colors: [Color.black, Color.bubblePurple],
    startPoint: .top, endPoint: .bottom)


struct SettingsView: View {
    @StateObject var highScoreViewModel = HighScoreViewModel()
    @State private var countdownInput = ""
    @State private var countdownValue: Double = 0
    @State private var numberOfBubbles: Double = 0
    @State private var playerName: String = ""
    
    
   
    var body: some View {
        ZStack{
            backgroundGradient
                .ignoresSafeArea()
            VStack{
                Label("Settings", systemImage: "")
                    .foregroundStyle(.bubblePurple)
                    .font(.title)
                    .opacity(0.6)
                    .bold()
                    .padding(.bottom, 30)
                
                ZStack{
                    Rectangle()
                        .cornerRadius(20)
                        .opacity(0.1)
                        .frame(width: 350, height: 140 )
                        .foregroundStyle(.bubblePurple)
                    VStack{
                        Text("Enter Your Name")
                            .font(.custom(
                                    "ArialRoundedMTBold",
                                    fixedSize: 22))
                            .foregroundStyle(.bubbleBlue)
                            
                        TextField("Enter Name", text: $playerName)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal, 40)
                    }
                }
                
                Spacer()
                
                ZStack{
                    Rectangle()
                        .cornerRadius(20)
                        .opacity(0.1)
                        .frame(width: 350)
                        .foregroundStyle(.bubblePurple)
                    VStack{
                        Text("Game Time")
                            .font(.custom(
                                    "ArialRoundedMTBold",
                                    fixedSize: 22))
                            .foregroundStyle(.bubbleBlue)
                            
                        ZStack{
                            LinearGradient(
                                gradient: Gradient(colors: [Color("#3EB489"), .bubblePurple]),
                                      startPoint: .leading,
                                      endPoint: .trailing
                                      
                                  )
                                .mask(Slider(value: $countdownValue, in: 0...60, step: 1))
                                .frame(width: 260, height: 50)
                            
                            Slider(value: $countdownValue, in: 0...60, step: 1)
                                .opacity(0.05)
                                .accentColor(.bubbleBlue)
                                .frame(width: 260, height: 50)
                                .padding()
                                .onChange(of: countdownValue, perform: { value in
                                    countdownInput = "\(Int(value))"
                                })
                                
                        }
                        .padding(.bottom, -20)
                        .padding(.top, -20)
                        Text(" \(Int(countdownValue)) sec")
                            .padding()
                            .foregroundColor(.bubblePurple)
                            .font(.custom(
                                    "ArialRoundedMTBold",
                                    fixedSize: 18))
                    }
                }

                
                ZStack{
                    Rectangle()
                        .cornerRadius(20)
                        .opacity(0.1)
                        .frame(width: 350 )
                        .foregroundStyle(.bubblePurple)
                    VStack{
                        Text("Max Number of Bubbles")
                            .font(.custom(
                                    "ArialRoundedMTBold",
                                    fixedSize: 22))
                            .foregroundStyle(.bubbleBlue)
                        ZStack{
                            LinearGradient(
                                gradient: Gradient(colors: [Color("#3EB489"), .bubblePurple]),
                                      startPoint: .leading,
                                      endPoint: .trailing
                                      
                                  )
                                .mask(Slider(value: $numberOfBubbles, in: 0...15, step: 1))
                                .frame(width: 260, height: 50)
                            
                            Slider(value: $numberOfBubbles, in: 0...15, step: 1)
                                .opacity(0.05)
                                .accentColor(.clear)
                                .padding()
                                .padding(.horizontal, 30)
                                .onChange(of: numberOfBubbles, perform: { value in
                                    numberOfBubbles = Double(Int(value))
                                })
                        }
                        .padding(.top, -20)

                        
                        Text("\(Int(numberOfBubbles))")

                            .foregroundColor(.bubblePurple)
                            .font(.custom(
                                    "ArialRoundedMTBold",
                                    fixedSize: 18))
                    }
                }
                .padding(.bottom, 40)
                
                

                
                NavigationLink(
                    destination: StartGameView(
                        playerName: playerName,
                        gameTime: Int(countdownValue),
                        maxNumOfBubbles: Int(numberOfBubbles)
                    ),
                    label: {
                        Text("Start Game")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: 250)
                            .padding()
                            .background(LinearGradient(
                                gradient: Gradient(colors: [Color.bubbleBlue.opacity(0.7), Color.blue.opacity(0.15)]),
                                startPoint: .bottom,
                                endPoint: .top
                            ))

                            .cornerRadius(60)
                    })
                Spacer()
                
            }
            .padding()
            .onDisappear{
                UserDefaults.standard.set(playerName, forKey: "playerName")
                
            }
        }
    }
}
#Preview {
    SettingsView()
}
