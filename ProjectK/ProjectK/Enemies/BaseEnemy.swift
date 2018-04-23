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
    
    
    init(){
        super.init(imageName: "alienYellow")
        
        //Create circular Physics body
        physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width/2,self.size.height/2))
        //physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody!.contactTestBitMask = physicsBody!.collisionBitMask
        
        name = "Enemy"
    }
    
    func Update(){
        if (isHidden){
            inUse = false
        }
        
        if (inUse){
            physicsBody?.velocity = CGVector(dx: -1450, dy: 0)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
