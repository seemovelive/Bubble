//
//  PlayerScoreModel.swift
//  BubblePopGame
//
//  Created by YUN on 18/4/2024.
//

import Foundation
struct PlayerScore: Identifiable, Codable{
var id = UUID()
    let playerName: String
    var score: Int
    
}
