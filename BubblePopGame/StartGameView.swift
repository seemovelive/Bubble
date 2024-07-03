//
//  StartGameView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

struct StartGameView: View {
    var playerName: String
    var gameTime: Int = 0
    var maxNumOfBubbles: Int = 0
    
    
    @State private var score: Int = 0
    @State private var isGameFinish: Bool = false
    
    @State private var currentTime = 0
    @State private var timer: Timer?
    
    @State private var initCountdown: Int = 3
    @State private var isCountingDown = true
    
    @State private var bubbleCount: Int = 0
    @State private var bubbleManager: BubbleManager = BubbleManager()
    @State private var bubbles = [Bubble]()
    @State private var playerScores: [PlayerScore] = []
    @State private var highestScore: Int = 0
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.bubblePurple)
                .ignoresSafeArea()
            
            if isCountingDown {
                Text("\(initCountdown)")
                    .font(.system(size: 90, weight: .bold))
                    .foregroundColor(.white)
                    .transition(.scale)
            } else {
                VStack {
                    ZStack{
                        Capsule()
                            .foregroundStyle(.bubbleBlue)
                            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                            .frame(width: 330, height: 60)
                        HStack {
                        Spacer()
                            VStack {
                                Text("Time Left")
                                    .bold()
                                Text("\(gameTime - currentTime)")
                            }.padding()
                            VStack {
                                Text("Score")
                                    .bold()
                                Text("\(score)")
                            }.padding()
                            VStack {
                                Text("High Score")
                                    .bold()
                                Text("\(highestScore)")
                            }.padding()
                            Spacer()
                        }.padding()
                    }
                    
                    
                    ZStack {
                        ForEach(bubbles, id: \.id) { bubble in
                            Button {
                                score += bubble.points
                                bubbles.removeAll { $0.id == bubble.id }
                            } label: {
                                Image(bubble.image)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .position(CGPoint(
                                x: bubble.x,
                                y: bubble.y
                            ))
                        }
                        .padding(10)
                    }
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $isGameFinish, content: {
            HighScoreView(playerName: playerName, score: score)
                .background(BackgroundClearView())
        })
        .onAppear {
            startCountdown()
            loadHighScore()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .onChange(of: score) { newValue in
                    if newValue > highestScore {
                        highestScore = newValue
                    }
                }
    }
    
    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if initCountdown > 0 {
                initCountdown -= 1
                withAnimation(.easeInOut(duration: 0.5)) {
                    isCountingDown = true
                }
            } else {
                tempTimer.invalidate()
                isCountingDown = false
                startGameTimer()
            }
        }
    }
    
    func startGameTimer() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { _ in
                if currentTime < gameTime {
                    currentTime += 1
                } else {
                    timer?.invalidate()
                    isGameFinish = true
                }
                
                if bubbles.count <= maxNumOfBubbles {
                    let num = Int.random(in: 0..<maxNumOfBubbles)
                    for _ in 0..<num {
                        if var bubble = bubbleManager.randomBubble() {
                            let screenBounds = UIScreen.main.bounds
                            bubble.id = UUID()
                            bubble.x = CGFloat.random(in: 0..<screenBounds.width - 50)
                            bubble.y = CGFloat.random(in: 0..<screenBounds.height - 50)
                            bubbles.append(bubble)
                        }
                    }
                    var exceedNum = bubbles.count - maxNumOfBubbles
                    while exceedNum > 0 {
                        let n = Int.random(in: 0..<bubbles.count)
                        bubbles.remove(at: n)
                        exceedNum -= 1
                    }
                }
        }
    }
    
    func loadHighScore() {
        if let data = UserDefaults.standard.data(forKey: "PlayerScores") {
            let decoder = JSONDecoder()
            if let scores = try? decoder.decode([PlayerScore].self, from: data) {
                highestScore = scores.map { $0.score }.max() ?? 0
            }
        }
    }
}





#Preview {
    StartGameView(playerName: "Yun", gameTime: 60, maxNumOfBubbles: 15  )
}
