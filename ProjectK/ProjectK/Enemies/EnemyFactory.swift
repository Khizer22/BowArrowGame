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
    
    //Spawning system
    var sendAmount : Int = 3
    var canSend = true
    
    //Timer
    var timer = Timer()
    var spawndelayTimer = Timer()
    var spawnDelay = 0.7
    
    var screenSize = CGSize()
    var Enemies = [BaseEnemy]()
    
    //difficutly
    var difficulty : Int = 0
    var oldDifficulty : Int = 0
    
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
        
        //SendEnemies()
    }
    
    func Update(){
        for enemies in Enemies{
           enemies.Update()
        }
        
        if (canSend){
            SendEnemies()
        }
    }
    
    //Init position and get screen size for reference
    func SetInitPosition(screenSize : CGSize){
        
        self.screenSize = screenSize
        position = CGPoint(x:screenSize.width/2,y:screenSize.height/2)
    }
    
    func SendEnemies(){
        
        //how many to send
        sendAmount = 3
        
        //start sending that many
        startSpawningTimer()
        
        canSend = false
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
                
                var i = arc4random() % 2;
                var q : Int = Int(i)
                
                enemies.position = CGPoint(x: screenSize.width,y: CGFloat(-350 * q))
                enemies.inUse = true
                
                //Spawning system
                //sendAmount -= 1
                
                break
            }
        }
        
        //if (sendAmount <= 0){
          //  timer.invalidate()
          //  setCanSend()
       //}
    }
    
    //TIMER TO START SPAWNER
    // Start Timer to set to idle state
    @IBAction func setCanSend() {
        spawndelayTimer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        spawndelayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SetCanSendTrue), userInfo: nil, repeats: false)
    }
    
    //Change back to idle State
    @objc func SetCanSendTrue() {
        canSend = true
    }
    
    func IncreaseSpeedForAll(){
        var newSpeedInc : CGFloat = 0
        
        if (oldDifficulty == difficulty){
            return
        }else{
            oldDifficulty = difficulty
        }
        
        if (difficulty == 0){
            newSpeedInc = 50
        }
        else if (difficulty == 1){
            newSpeedInc = 100
        }
        else if (difficulty == 2){
            newSpeedInc = 120
        }
        else if (difficulty == 3){
            newSpeedInc = 150
        }
        else if (difficulty == 4){
            newSpeedInc = 200
        }
        
        for enemies in Enemies{
            enemies.IncreaseSpeed(speedIncrease: newSpeedInc)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
