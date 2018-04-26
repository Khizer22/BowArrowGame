//
//  Enemy.swift
//  ProjectK
//
//  Created by Mahboob Khizer on 3/22/18.
//  Copyright © 2018 Khizer. All rights reserved.
//


import Foundation
import SpriteKit

class BaseEnemy : GameObject{
    
    //Object pooling
    var inUse : Bool = false
    
    //paramters
    var currentSpeed : CGFloat = -450
    
    //AnimationTextures
    var idleTextures = [SKTexture]()
    var deadTextures = [SKTexture]()    
    
    init(){
        super.init(imageName: "flyingDude_01")
        
        //Create circular Physics body
        //physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width/2,self.size.height/2))
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width,                                                                            height: size.height))
        //physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody!.contactTestBitMask = physicsBody!.collisionBitMask
        
        name = "Enemy"
        
        isHidden = true
        
        PlayAnimation(animTextures: idleTextures, animFPS: 0.2)
        
        //fix direction
        xScale = -xScale
    }
    
    func IncreaseSpeed(speedIncrease : CGFloat){
        currentSpeed -= speedIncrease
    }
    
    func Update(){
        if (isHidden){
            inUse = false
        }
        
        if (inUse){
            physicsBody?.velocity = CGVector(dx: currentSpeed, dy: 0)
        }
    }

    override func InitAnimations() {
        //IDLE
        for index in 1 ... 4 {
            let textureName = "flyingDude_0\(index)"
            let texture = SKTexture(imageNamed: textureName)
            idleTextures.append(texture)
        }
        //Dead
        for index in 1 ... 4 {
            let textureName = "flyingDude_0\(index)"
            let texture = SKTexture(imageNamed: textureName)
            deadTextures.append(texture)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
