//
//  EnemyFactory.swift
//  ProjectK
//
//  Created by Mahboob Khizer on 4/19/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyFactory : SKNode{
    
    //Enemy spawning parameters
    var moveSpeed : CGFloat = 5.0
    var damage : CGFloat = 5.0
    
    var screenSize = CGSize()
    var Enemies = [BaseEnemy]()
    
    override init(){
        super.init()
        
        //TEMP
        Enemies.append(BaseEnemy())
        
        for enemies in Enemies{
            addChild(enemies)
        }
    }
    
    //Init position and get screen size for reference
    func SetInitPosition(screenSize : CGSize){
        
        self.screenSize = screenSize
        position = CGPoint(x:screenSize.width/2,y:screenSize.height/2)
    }
    
    //Spawn enemies
    func SpawnEnemies(){
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
