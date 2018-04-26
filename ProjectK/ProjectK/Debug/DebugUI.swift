//
//  DebugUI.swift
//  ProjectK
//
//  Created by Mahboob Khizer on 4/19/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit
/*
let winner = SKLabelNode(fontNamed: "Chalkduster")
winner.text = "You Win!"
winner.fontSize = 65
winner.fontColor = SKColor.green
winner.position = CGPoint(x: frame.midX, y: frame.midY)

addChild(winner)
 */

class DebugUI : SKLabelNode{
        
    override init() {
        super.init()
        
        fontName = "ChalkDuster"
        text = "You Win!"
        fontSize = 65
        fontColor = SKColor.white
        position = CGPoint(x: 300, y: 1200)
        
      
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
 

}
