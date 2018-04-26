//
//  BaseCharacter.swift
//  ProjectK
//
//  Created by Khizer Mahboob on 3/20/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit

class GameObject : SKSpriteNode {
    
    var moveSpeed : CGFloat = 10.0
    var moveToTarget = CGPoint(x: 0, y: 0)
    var rotateToTarget = CGPoint (x:0, y: 0)
    var initPos = CGPoint(x: 0, y: 0)
    var screenSize = CGSize()
    
    var currentHealth : Int = 5
    
    init(imageName : String) {
        let texture = SKTexture(imageNamed : imageName)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        InitAnimations()
    }

    //Init position and get screen size for reference
    func SetInitPosition(screenSize : CGSize){
        self.screenSize = screenSize
    }
    
    //Init animations if object has them
    func InitAnimations(){}
    
    func ChangeAnimation(){}
    
    func PlayAnimation(animTextures : [SKTexture], animFPS : TimeInterval){
        let animate = SKAction.animate(with: animTextures,timePerFrame: animFPS,resize: true,restore: false)
        let repeatAnimation = SKAction.repeatForever(animate)
        run(repeatAnimation)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}

