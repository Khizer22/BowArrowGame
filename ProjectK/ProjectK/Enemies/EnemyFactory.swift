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
    
    //Timer
    var timer = Timer()
    var spawnDelay = 1.0
    
    var screenSize = CGSize()
    var Enemies = [BaseEnemy]()
    
    override init(){
        super.init()
        
        Enemies.append(BaseEnemy())
        Enemies.append(BaseEnemy())
        Enemies.append(BaseEnemy())
        Enemies.append(BaseEnemy())
        Enemies.append(BaseEnemy())
        
        for enemies in Enemies{
            //enemies.position = CGPoint(x: 500,y: 500)
            addChild(enemies)
        }
        
        //TEST
        startSpawningTimer()
    }
    
    func Update(){
        for enemies in Enemies{
           enemies.Update()
        }
    }
    
    //Init position and get screen size for reference
    func SetInitPosition(screenSize : CGSize){
        
        self.screenSize = screenSize
        position = CGPoint(x:screenSize.width/2,y:screenSize.height/2)
    }
    
    //TIMER TO START SPAWNING ENEMIES
    // Start Timer to set to idle state
    @IBAction func startSpawningTimer() {
        timer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: spawnDelay, target: self, selector: #selector(SpawnEnemies), userInfo: nil, repeats: true)
    }
    
    //Change back to idle State
    @objc func SpawnEnemies() {
        for enemies in Enemies{
            if (enemies.inUse == false){
                enemies.isHidden = false
                enemies.position = CGPoint(x: screenSize.width,y: 0)
                enemies.inUse = true
                break
            }
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
