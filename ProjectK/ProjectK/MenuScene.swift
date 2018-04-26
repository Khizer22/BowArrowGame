//
//  MenuScene.swift
//  ProjectK
//
//  Created by Mahboob Khizer on 4/23/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    
    //var playButton = SKSpriteNode()
    //let playButtonTex = SKTexture(imageNamed: "play")
    var MenuText = SKLabelNode()
    var MenuText2 = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        //playButton = SKSpriteNode(texture: playButtonTex)
        ////playButton.position = CGPoint(x: frame.midX, y: frame.midY)
        //self.addChild(playButton)
        
        MenuText.fontName = "ChalkDuster"
        MenuText.fontSize = 105
        MenuText.fontColor = SKColor.white
        MenuText.position = CGPoint(x: size.width/2 - 100, y: 1000)
        MenuText.text = "Karate Kitty"
        
        MenuText2.fontName = "ChalkDuster"
        MenuText2.fontSize = 65
        MenuText2.fontColor = SKColor.white
        MenuText2.position = CGPoint(x: 1200, y: 800)
        MenuText2.text = "Tap To Play"
        
        addChild(MenuText)
        addChild(MenuText2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            if node == playButton {
 */
                if let view = view {
                    let transition:SKTransition = SKTransition.fade(withDuration: 1)
                    let scene:SKScene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition: transition)
                }
            //}
        //}
    }
}
