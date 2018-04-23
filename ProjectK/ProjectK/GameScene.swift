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
    let player = Player()
    //let arrow = Projectile()
   // let enemy = Enemy()
    let enemyFactory = EnemyFactory()
    let background = SKSpriteNode(imageNamed: "Background3")
    
    var baseObjects = [GameObject]()
    
    //DEBUG
    var debugUI = DebugUI()
    
    override func didMove(to view: SKView) {
        //test background
        backgroundColor = SKColor.white
        
        //Init background
        background.position = CGPoint(x: size.width / 2, y: size.height / 2 )
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
        
        //Physics
        physicsWorld.contactDelegate = self
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        //arrow.Update(currentTime: currentTime)
        
        //enemy.SetTarget(newTarget: CGPoint(x:size.width,y: size.height/1.25))
        //enemy.Update()
        
        enemyFactory.Update()
        
        //DEBUG UI
       // debugUI.text = "State: " + player.myState.rawValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        //player.SetTarget(newTarget: touch.location(in: self))  //set target for player to move to
        //player.SetRotateTarget(newTarget: touch.location(in: self))  //set target for rotation
        //player.RotateTowards() //rotate towards target
        
        //Arrow
        //arrow.GetInitialPosition(initPos: touch.location(in: self))
        
        //Player Gather Input
        player.GetInitialPosition(initPos: touch.location(in: self))
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let touch: UITouch = touches.first as! UITouch
        
        //Arrow
        //arrow.GetFinalPosition(finalPos: touch.location(in: self))
        
        //Player Gather Input End
        player.GetFinalPosition(finalPos: touch.location(in: self))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first as! UITouch
        
        //player.SetRotateTarget(newTarget: touch.location(in: self))  //set target for rotation
        //player.RotateTowards() //rotate towards target
    }
 
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Player" {
            NSLog("%@", "Hit Player")
            contact.bodyB.node?.isHidden = true
            
            //Player loses hp
            
            //OR
            
            //Player gains score when contact is with attack box and ball
        }
    }
}
