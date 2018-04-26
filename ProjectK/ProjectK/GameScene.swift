//
//  GameScene.swift
//  ProjectK
//
//  Created by Khizer Mahboob on 3/20/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene , SKPhysicsContactDelegate{
    let gameMode = GameMode()
    
    let player = Player()
    let enemyFactory = EnemyFactory()
    let background = SKSpriteNode(imageNamed: "dark_background")
    
    var baseObjects = [GameObject]()
    
    //Particle
    let emitter = SKEmitterNode(fileNamed: "EnemyDead.sks")
    var particleTimer = Timer()
    
    //DEBUG
    var debugUI = DebugUI()
    
    override func didMove(to view: SKView) {
        //test background
        backgroundColor = SKColor.white
        
        //Init background
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
        background.setScale(2)
        background.xScale *= -1
        addChild(background)
        background.zPosition = -1
        
        baseObjects = [player]
        
        //init all game objects
        for objects in baseObjects{
            addChild(objects)
            objects.SetInitPosition(screenSize : size)
        }
        
        //EnemyFactory
        addChild(enemyFactory)
        enemyFactory.SetInitPosition(screenSize: size)
        
        //DEBUG
        addChild(debugUI)
        
        //GameMode
        addChild(gameMode)
        gameMode.UpdateHealth(currentHP: player.currentHealth)
        
        //Physics
        physicsWorld.contactDelegate = self
        
        //Particle
        emitter?.position = CGPoint(x: 0, y: -40)
        emitter?.isHidden = true
        emitter?.name = "hit"
        
        // Send the particles to the scene.
        emitter?.targetNode = scene;
        //emitter?.isHidden = true
        scene!.addChild(emitter!)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        enemyFactory.Update()
        
        //DEBUG UI
        debugUI.text = "State: " + player.myState.rawValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        //Player Gather Input
        player.GetInitialPosition(initPos: touch.location(in: self))
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        //Player Gather Input End
        player.GetFinalPosition(finalPos: touch.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first as! UITouch
    }
 
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" {
            NSLog("%@", "Hit Player")
            contact.bodyB.node?.isHidden = true
            
            //Player loses hp
            player.TakeDamage(damageAmount: 1)
            gameMode.UpdateHealth(currentHP: player.currentHealth)
            
            //OR
            
            //Player gains score when contact is with attack box and ball
        }
        else if contact.bodyA.node?.name == "attackBox" {
            if (contact.bodyB.node?.isHidden == false){
                //add score if not hidden
                gameMode.AddScore(amount: 1)
                
                //play particle
                emitter?.position = (contact.bodyB.node?.position)!
                emitter?.isHidden = false
                //stop particle after a while
                stopParticleTime()
            }
            //hide it
            contact.bodyB.node?.isHidden = true
            //update difficulty
            enemyFactory.difficulty = gameMode.UpdateDifficulty()
            enemyFactory.IncreaseSpeedForAll()
        }
    }
    
    //***TIMER FOR STARTING PARTICLE***
    
    // Start Timer to set to idle state
    @IBAction func stopParticleTime() {
        particleTimer.invalidate()
        
        // start the timer
        particleTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(StopParticle), userInfo: nil, repeats: false)
    }
    
    @objc func StopParticle() {
        emitter?.isHidden = true
    }
    
    //*** END TIMER FOR STOPPING COLLIDER ***//
}
