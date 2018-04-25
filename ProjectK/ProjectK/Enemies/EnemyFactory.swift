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
    var spawnDelay = 0.3
    
    var screenSize = CGSize()
    var Enemies = [BaseEnemy]()
    
    //difficutly
    var difficulty : Int = 0
    
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
                enemies.position = CGPoint(x: screenSize.width,y: 0)
                enemies.inUse = true
                
                //Spawning system
                sendAmount -= 1
                
                break
            }
        }
        
        if (sendAmount <= 0){
            timer.invalidate()
            setCanSend()
        }
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
