//
//  Enemy.swift
//  ProjectK
//
//  Created by Mahboob Khizer on 3/22/18.
//  Copyright © 2018 Khizer. All rights reserved.
//


import Foundation
import SpriteKit

class Enemy : GameObject{
    
    init(){
        super.init(imageName: "alienYellow")
        
        //Create circular Physics body
        physicsBody = SKPhysicsBody(circleOfRadius: max(self.size.width/2,self.size.height/2))
        physicsBody?.affectedByGravity = false
        
        
    }
    
    override func SetInitPosition(screenSize: CGSize) {
        super.SetInitPosition(screenSize : screenSize)
        initPos = CGPoint(x: 0 - size.width/2, y: screenSize.height - (size.height/2 + 300))
        position = initPos
    }
    
    func Update(){
        //move left or right
        physicsBody?.velocity = CGVector(dx: 550, dy: 0)
        
      //  if (position.x > screenSize.x){
            //SetTarget(newTarget: CGPoint(x: -screenSize.x,y: screenSize.y / 1.25)) //change later
          //  physicsBody?.velocity = CGVector(dx: -350, dy: 0)
       /// }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
