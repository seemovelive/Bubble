//
//  ContentView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

let backgroundGradient = LinearGradient(
    colors: [Color.black, Color.bubblePurple],
    startPoint: .top, endPoint: .bottom)

struct ContentView: View {
    @State private var playerName: String = ""
    
    var body: some View {
        NavigationView{
            ZStack{
//                Rectangle()
                backgroundGradient
                    .ignoresSafeArea()
                
                VStack {
                   
                    ZStack{
                        Image("logo").resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250, alignment: .bottom)
                            .padding(.top, -20)
                        
                        Image("bubble").resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .bottom)
                            .opacity(0.05)
                            .padding(.top, 100)
                        Image("bubble2").resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .bottom)
                            .opacity(0.8)
                            .padding(.top, 40)
                    }
                    
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: SettingsView(),
                        label: {
                            Text("New Game")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: 250)
                                .padding()
                                .background(LinearGradient(
                                    gradient: Gradient(colors: [Color.bubbleBlue.opacity(0.7), Color.blue.opacity(0.15)]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                ))

                                .cornerRadius(50)
                        })
                    .padding(20)
                    
                    NavigationLink(
                        destination: HighScoreView(playerName: "", score: 0),
                        label: {
                            Text("High Score")
                                .font(.title)
                                .bold()
                                .foregroundColor(.white.opacity(0.9))
                                .frame(maxWidth: 250)
                                                        .padding()
                                .background(LinearGradient(
                                    gradient: Gradient(colors: [Color.bubbleBlue.opacity(0.7), Color.blue.opacity(0.15)]),
                                    startPoint: .bottom,
                                    endPoint: .top
                                ))
                                                        .cornerRadius(50)
                        })
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
