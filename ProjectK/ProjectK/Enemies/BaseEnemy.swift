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
    
    
    init(){
        super.init(imageName: "flyingDude_02")
        
        //Create circular Physics body
        physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width/2,self.size.height/2))
        //physicsBody?.isDynamic = false
        physicsBody?.allowsRotation = false
        physicsBody?.affectedByGravity = false
        physicsBody!.contactTestBitMask = physicsBody!.collisionBitMask
        
        name = "Enemy"
        
        isHidden = true
        
        //TEMP
        //setScale(scale : 2.0)
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
