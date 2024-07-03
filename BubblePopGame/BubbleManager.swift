//
//  BubbleManager.swift
//  BubblePopGame
//
//  Created by YUN on 20/4/2024.
//

import Foundation
import UIKit

struct Bubble : Identifiable {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let buffer: CGFloat = 20.0
    var image: String
    var points: Int
    var probability: Double
    var x: CGFloat = 0
    var y: CGFloat = 0
    var id: UUID = UUID()
}

class BubbleManager : ObservableObject {
    @Published private(set) var bubbles = [Bubble]()
    private var maxBubbles = 15

    // Predefined bubbles with their properties
    private let bubbleTypes = [
        Bubble(image: "bubbleRed", points: 1, probability: 0.4),
        Bubble(image: "bubblePurple", points: 2, probability: 0.3),
        Bubble(image: "bubbleGreen", points: 5, probability: 0.15),
        Bubble(image: "bubbleBlue", points: 8, probability: 0.1),
        Bubble(image: "bubbleRanbow", points: 10, probability: 0.05)
    ]

    func generateBubbles() {
        bubbles.removeAll()
        for _ in 1...maxBubbles {

            if var bubble = randomBubble() {
                bubbles.append(bubble)
            }
        }
    }
    
    func popBubble() -> Bubble? {
        return bubbles.popLast()
    }

    public func randomBubble() -> Bubble? {
        let totalProbability = bubbleTypes.reduce(0) { $0 + $1.probability }
        var rand = Double.random(in: 0..<totalProbability)
        for bubble in bubbleTypes {
            if rand < bubble.probability {
                return bubble
            }
            rand -= bubble.probability
        }
        return nil
    }
}

