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
    
    enum EState {
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
    
    var myState : EState = EState.Idle
    
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
        
        endTouchPos = finalPos
        
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
        
        if (hypotenuse >= consideredForSwipe){
            //Check if swiping up or down
            if (abs(finalPos.y) > abs(finalPos.x)){
                if (finalPos.y >= 0){
                    NSLog("%@", "SWIPE-UP")
                }
                else{
                    NSLog("%@", "SWIPE-DOWN")
                }
            }
            else{
                NSLog("%@", "SWIPE-RIGHT")
            }
            
        }
        else{
            //Check what part of screen is tapped
            if (finalPos.y >= screenSize.height/2){
                ChangeState(newState: EState.JabUP)
                NSLog("%@", "JAB-UP")
            }
            else if (finalPos.y < screenSize.height/2){
                ChangeState(newState: EState.JabDOWN)
                NSLog("%@", "JAB-DOWN")
            }
      
        }
        
        /*
        endShootPos = finalPos
        
        //Calculate Shoot Force and dir
        var shootDir = CGPoint(x: startShootPos.x - endShootPos.x, y: startShootPos.y - endShootPos.y)
        //let hypotenuse = sqrt(shootDir.x * shootDir.x + shootDir.y * shootDir.y)
        
        //Shoot arrow if not in air
        if (myState == EState.Dormant){
            Shoot(shootForce : CGVector(dx: shootForce * shootDir.x, dy: shootForce * shootDir.y))
            SetState(myState: EState.Reloading)
            shootTime = gameTime + reloadSpeed
        }
 */
    }
    
    //Change State
    func ChangeState(newState : EState){
        myState = newState
       
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
