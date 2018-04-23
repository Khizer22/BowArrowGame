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
    
    var Enemies = [GameObject]()
    var paan = Enemy()
    
    override init(){
        super.init()
        Enemies.append(Enemy())
    }
    
    //Init position and get screen size for reference
    func SetInitPosition(screenSize : CGSize){
        //init all game objects
        for enemies in Enemies{
            enemies.SetInitPosition(screenSize : screenSize)
            enemies.position = CGPoint(x: 500, y: 500)
        }
        paan.position = CGPoint(x: 500, y: 500)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
