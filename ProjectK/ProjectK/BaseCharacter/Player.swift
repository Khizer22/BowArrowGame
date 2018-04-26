//
//  Player.swift
//  ProjectK
//
//  Created by Khizer Mahboob on 3/20/18.
//  Copyright © 2018 Khizer. All rights reserved.
//

import Foundation
import SpriteKit

class Player : GameObject{
    
    enum EState : String {
        //Idle
        case Idle
        //Jabs
        case JabUP
        case JabDOWN
        //Specials
        case LongKick
        case JumpAttack
        //Hurt
        case Hurt
        case Dead
    }
    
    //State
    var myState : EState = EState.Idle
    var backToIdleTime : TimeInterval = 1.0
    
    //AnimationTextures
    var idleTextures = [SKTexture]()
    var jabUpTextures = [SKTexture]()
    var jabDownTextures = [SKTexture]()
    var deathTextures = [SKTexture]()
    var longKickTextures = [SKTexture]()
    var jumpickTextures = [SKTexture]()
    //more later.....
    
    //Timer
    var timer = Timer()
    var hurtTimer = Timer()
    var attackTimer = Timer()
    var stopAttackTimer = Timer()
    
    //touch locations
    var startTouchPos = CGPoint(x: 0, y: 0)
    var endTouchPos = CGPoint(x: 0, y: 0)
    let consideredForSwipe : CGFloat = 300.0
    
    //Parameters
    let attackNode = SKNode()
    let attackXLocation = 150
    let jabDownLocation = -150
    let jabUpLocation = 150
    let nuetralLocation = 950
    var lastState = EState.Idle
    
    //DEBUG
    var naan = SKShapeNode(rectOf: CGSize(width: 350, height: 150))
    
    init(){
        super.init(imageName: "cat_02")
        
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width,                                                                            height: size.height))
        physicsBody?.pinned = true
        physicsBody?.allowsRotation = false
        //physicsBody?.isDynamic = false
        //physicsBody?.affectedByGravity = false
        physicsBody!.contactTestBitMask = physicsBody!.collisionBitMask
        
        //physics body for attacking
        attackNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 350,                                                                             height: 150))
        attackNode.physicsBody?.pinned = true
        attackNode.physicsBody?.allowsRotation = false
        attackNode.physicsBody!.contactTestBitMask = attackNode.physicsBody!.collisionBitMask
        attackNode.name = "attackBox"
        attackNode.position = CGPoint(x: attackXLocation, y: nuetralLocation)
        addChild(attackNode)
        
        //TESTING
        //self.naan = SKShapeNode(rectOf: CGSize(width: 350, height: 150))
        naan.name = "bar"
        naan.fillColor = UIColor.black
        naan.position = attackNode.position
        
        addChild(naan)
        //TESTING END
        
        name = "Player"
        
        PlayAnimation(animTextures: idleTextures, animFPS: 0.1)
    
    }
    
    override func SetInitPosition(screenSize: CGSize) {
        super.SetInitPosition(screenSize: screenSize)
        
        //Set position depending on Screen
        initPos = CGPoint(x: size.width/2 + 300, y: 550)
        position = initPos
        
        //Scale up the player
        //scale(to: CGSize(width: 550, height: 750))

    }
    
    //Get Initial Touch Position
    func GetInitialPosition(initPos : CGPoint){
        startTouchPos = initPos
    }
    
    //Get Final Touch Position
    func GetFinalPosition(finalPos : CGPoint){
        
        if (myState == EState.Idle){
            endTouchPos = finalPos
            SetState(newState: CalculateNewStateFromInput())
        }
    }
    
    //Change State
    func SetState(newState : EState){
        
        //Dont switch to same state unless its the hurt state
        if (myState == newState && myState != EState.Hurt){
            return
        }
        
        lastState = myState
        myState = newState
        startIdleTimer()
       
        //Play New Animation based on state
        ChangeAnimation()
        
        
    }
    
    override func ChangeAnimation() {
        switch myState {
        case EState.Idle:
            PlayAnimation(animTextures: idleTextures, animFPS: 0.1)
        case EState.JabUP:
            PlayAnimation(animTextures: jabUpTextures, animFPS: 0.05)
            StartAttack()
        case EState.JabDOWN:
            PlayAnimation(animTextures: jabDownTextures, animFPS: 0.05)
            StartAttack()
        case EState.Dead:
            //PlayAnimation(animTextures: deathTextures, animFPS: 0.5)
            let animate = SKAction.animate(with: deathTextures,
                                           timePerFrame: 0.5,resize: true,restore: false)
            run(animate)
        default:
            PlayAnimation(animTextures: idleTextures, animFPS: 0.1)

        }
    }
    
    //***TIMER FOR IDLE STATE***
    
    // Start Timer to set to idle state
    @IBAction func startIdleTimer() {
        timer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
       timer = Timer.scheduledTimer(timeInterval: backToIdleTime, target: self, selector: #selector(ChangeToIdleState), userInfo: nil, repeats: false)
    }
    
    //Change back to idle State
    @objc func ChangeToIdleState() {
        if (currentHealth > 0){
            SetState(newState: EState.Idle)
        }
        else{
            timer.invalidate()
        }
    }
    
    //*** END TIMER FOR IDLE ***//
    
    //***TIMER FOR STARTING COLLIDER***
    
    // Start Timer to set to idle state
    @IBAction func startAttackTimer() {
        attackTimer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        attackTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(StartAttack), userInfo: nil, repeats: false)
    }
    
    @objc func StartAttack() {
        if (currentHealth > 0){
            if (myState == EState.JabUP){
                attackNode.position = CGPoint(x: attackXLocation, y: jabUpLocation)
            }
            else if (myState == EState.JabDOWN){
                attackNode.position = CGPoint(x: attackXLocation, y: jabDownLocation)
            }
            //DEBUG
            naan.position = attackNode.position
        }
        else{
            attackTimer.invalidate()
        }
        
        stopAttackTime()
    }
    
    //*** END TIMER FOR STARTING COLLIDER ***//
    //***TIMER FOR STOPPING COLLIDER***
    
    // Start Timer to set to idle state
    @IBAction func stopAttackTime() {
        stopAttackTimer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        stopAttackTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(StopAttack), userInfo: nil, repeats: false)
    }
    
    @objc func StopAttack() {
        if (currentHealth > 0){
            attackNode.position = CGPoint(x: attackXLocation, y: nuetralLocation)
            //DEBUG
            naan.position = attackNode.position
        }
        else{
            stopAttackTimer.invalidate()
        }
    }
    
    //*** END TIMER FOR STOPPING COLLIDER ***//
    
    //Calculate New State From Input
    func CalculateNewStateFromInput() -> EState{
        
        var newState : EState = EState.Idle

        //Determine what kind of attack to do
        //****ATTACKS****
        //Swipe up = Jump Attack
        //Swipe Right = Long Kick
        //Tap Up side of  screen = Jab up
        //Tab Bottom side of screen = Jab Down
        //Might add block/parry
        //****ATTACKS END*****
        
        //Calculate Length of touches
        var TouchDir = CGPoint(x: startTouchPos.x - endTouchPos.x, y: startTouchPos.y - endTouchPos.y)
        let hypotenuse = sqrt(TouchDir.x * TouchDir.x + TouchDir.y * TouchDir.y)
        
        //SWIPPING
        if (hypotenuse >= consideredForSwipe){
            //Check if swiping up or down
            if (abs(TouchDir.y) > abs(TouchDir.x)){
                if (TouchDir.y >= 0){
                    NSLog("%@", "SWIPE-DOWN")
                    newState = EState.JumpAttack
                    backToIdleTime = 0.5
                }
                else{
                    NSLog("%@", "SWIPE-UP")
                    newState = EState.JumpAttack
                    backToIdleTime = 0.5
                }
            }
            else{
                NSLog("%@", "SWIPE-RIGHT")
                newState = EState.LongKick
                backToIdleTime = 1.0
            }
            
            //TAPPING
        }
        else{
            //Check what part of screen is tapped
            if (endTouchPos.y >= screenSize.height/2){
                newState = EState.JabUP
                backToIdleTime = 0.3
                NSLog("%@", "JAB-UP")
            }
            else if (endTouchPos.y < screenSize.height/2){
                newState = EState.JabDOWN
                backToIdleTime = 0.3
                NSLog("%@", "JAB-DOWN")
            }
            
        }
        
        return newState
    }
    
    override func InitAnimations() {
        //IDLE
        for index in 1 ... 4 {
            let textureName = "cat_0\(index)"
            let texture = SKTexture(imageNamed: textureName)
            idleTextures.append(texture)
        }
        //JabUp
        for index in 47 ... 52 {
            let textureName = "cat_\(index)"
            let texture = SKTexture(imageNamed: textureName)
            jabUpTextures.append(texture)
        }
        //JabLow
        for index in 13 ... 20 {
            let textureName = "cat_\(index)"
            let texture = SKTexture(imageNamed: textureName)
            jabDownTextures.append(texture)
        }
        //Death
        for index in 31 ... 39{
            let textureName = "cat_\(index)"
            let texture = SKTexture(imageNamed: textureName)
            deathTextures.append(texture)
        }

    }
    
    func TakeDamage(damageAmount : Int){
        if (currentHealth > 0){
            currentHealth -= damageAmount
            PlayHurtSprite()
        }
        if (currentHealth <= 0){
            SetState(newState: EState.Dead)
        }
    }
    
    func PlayHurtSprite(){
        //self.color = UIColor.red
       // self.colorBlendFactor = 1
        
        let action = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 0.2)
        run(action)
        startReturnColorTimer()
    }
    
    // Start Timer to set to idle state
    @IBAction func startReturnColorTimer() {
        hurtTimer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        hurtTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ChangeColorToDefault), userInfo: nil, repeats: false)
    }
    
    //Change back to idle State
    @objc func ChangeColorToDefault() {
        let action = SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 0.1)
        run(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
