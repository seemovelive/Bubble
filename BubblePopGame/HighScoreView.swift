//
//  HighScoreView.swift
//  BubblePopGame
//
//  Created by Firas Al-Doghman on 29/3/2024.
//

import SwiftUI

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct HighScoreView: View {
    @State private var playerScores:[PlayerScore] = [] //bring playerScore Mode
    
    var playerName: String
    var score : Int

    
    var body: some View {
        ZStack{
//            Rectangle()
//                                .fill(.thickMaterial)
            backgroundGradient
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Label("✨ High Score ✨", systemImage: "")
                    .foregroundStyle(.bubblePurple)
                    .font(.title)
                    .bold()
                
                List(playerScores.sorted(by: {$0.score > $1.score}).prefix(10)) {playerScore in Text("\(playerScore.playerName):\(playerScore.score)")}
                
                
                
                Spacer()

                Spacer()
            }
        }
        
        .onAppear{
            loadPlayerScores()
            savePlayerScore()
            
        }
        
    }
    

    private func loadPlayerScores(){
        if let data = UserDefaults.standard.data(forKey: "PlayerScores"){
            let decoder = JSONDecoder()
            if let decodedPlayerScores = try?
                decoder.decode([PlayerScore].self, from: data){
                playerScores = decodedPlayerScores
                
            }
        }
    }
    
    private func savePlayerScore(){
        let newPlayerScore = PlayerScore(playerName: playerName, score: score)
        playerScores.append(newPlayerScore)
        let encoder = JSONEncoder()
        if let encoded = try?
            encoder.encode(playerScores){
            UserDefaults.standard.set(encoded, forKey: "PlayerScores")
        }
    }
    

    

}

#Preview {
    HighScoreView(playerName: "", score: 0)
}
