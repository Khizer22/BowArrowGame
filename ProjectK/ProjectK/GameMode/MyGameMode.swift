//
//  MyGameMode.swift
//  ProjectK
//
//  Created by Mahboob Khizer on 4/25/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit

class GameMode : SKNode{
    
    //Parameters
    var scoreText = SKLabelNode()
    var score = 0
    var healthText = SKLabelNode()
    
    //difficulty
    var difficulty : Int = 0
    
    override init() {
        super.init()
        
        scoreText.fontName = "ChalkDuster"
        scoreText.fontSize = 65
        scoreText.fontColor = SKColor.black
        scoreText.position = CGPoint(x: 1200, y: 1200)
        scoreText.text = "Score: 0"
        
        addChild(scoreText)
        
        healthText.fontName = "ChalkDuster"
        healthText.fontSize = 65
        healthText.fontColor = SKColor.white
        healthText.position = CGPoint(x: 1200, y: 1000)
        healthText.text = "Health: 10"
        
        addChild(healthText)
    }
    
    func AddScore(amount : Int){
        score += amount
        UpdateScore()
    }
    
    func UpdateScore(){
        scoreText.text = "Score: \(score)"
    }
    
    func UpdateHealth(currentHP : Int){
        healthText.text = "Health: \(currentHP)"
    }
    
    func UpdateDifficulty() -> Int{
        if (score == 10){
            difficulty += 1
        }
        else if (score == 20){
            difficulty += 1
        }
        else if (score == 40){
            difficulty += 1
        }
        else if (score == 80){
            difficulty += 1
        }
        else if (score == 120){
            difficulty += 1
        }
        
        return difficulty
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
