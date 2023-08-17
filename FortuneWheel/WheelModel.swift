//
//  WheelModel.swift
//  FortuneWheel
//
//  Created by Alina Bondarchuk on 16.08.2023.
//

import Foundation

class WheelModel {
    private var totalScore: Int = 0
    private var lastScore: Int = 0
    
    private let totalScoreKey = "totalScoreKey"
    
    init() {
        totalScore = UserDefaults.standard.integer(forKey: totalScoreKey)
    }
    
    func getTotalScore() -> Int {
        return totalScore
    }
    
    func getlastScore() -> Int {
        return lastScore
    }
    
    func spinWheel() -> (stoppingSection: Int, points: Int) {
        let randomSection = Int.random(in: 0..<16)
        let sectionPoints = 100 + randomSection * 100
        totalScore += sectionPoints
        lastScore = sectionPoints
        return (randomSection, sectionPoints)
    }
    
    func saveTotalScore() {
        UserDefaults.standard.set(totalScore, forKey: totalScoreKey)
    }
}
