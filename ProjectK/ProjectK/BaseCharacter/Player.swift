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
    
    //Timer
    var timer = Timer()
    
    //touch locations
    var startTouchPos = CGPoint(x: 0, y: 0)
    var endTouchPos = CGPoint(x: 0, y: 0)
    let consideredForSwipe : CGFloat = 300.0
    
    //Parameters
    
    init(){
        super.init(imageName: "Player")
    }
    
    override func SetInitPosition(screenSize: CGSize) {
        super.SetInitPosition(screenSize: screenSize)
        
        //Set position depending on Screen
        initPos = CGPoint(x: size.width/2 + 300, y: 400)
        position = initPos
        
        //Scale up the player
        scale(to: CGSize(width: 350, height: 350))
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
                
        myState = newState
        startIdleTimer()
       
        //Play New Animation based on state
        ChangeAnimation()
    }
    
    func ChangeAnimation(){
        //Play new animation
        texture = SKTexture(imageNamed: "Player")
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
        SetState(newState: EState.Idle)
        texture = SKTexture(imageNamed: "Player2")
    }
    
    //*** END TIMER FOR IDLE ***//
    
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
                backToIdleTime = 0.1
                NSLog("%@", "JAB-UP")
            }
            else if (endTouchPos.y < screenSize.height/2){
                newState = EState.JabDOWN
                backToIdleTime = 0.1
                NSLog("%@", "JAB-DOWN")
            }
            
        }
        
        return newState
    }
    
    /*
    func RotateTowards(){
        
        var rotateToPos = CGPoint(x: position.x - rotateToTarget.x, y: position.y - rotateToTarget.y)
        //let length = sqrt(moveToPos.x * moveToPos.x + moveToPos.y * moveToPos.y)
        let angle = atan2(-rotateToPos.x, rotateToPos.y)
        
        zRotation = (angle - 90 * CGFloat(Double.pi/180.0)) + 135
        //NSLog("%f", zRotation * CGFloat(180.0 / Double.pi));
        
        //if moving
        //if (abs(position.x - moveToTarget.x) > moveSpeed + 1)
    }
 */
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("asdf")
    }
}
