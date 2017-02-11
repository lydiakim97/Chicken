//
//  GameScene.swift
//  iOSGame
//
//  Created by Kevin Tieu on 2017-02-09.
//  Copyright © 2017 Kevin Tieu. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // 1
    let chicken = SKSpriteNode(imageNamed: "chicken")
    var chickenPosition = ""
    var currentPlacement = -1
    let Circle1 = SKShapeNode(circleOfRadius: 50 )
    let Circle2 = SKShapeNode(circleOfRadius: 50 )
    let Circle3 = SKShapeNode(circleOfRadius: 50 )
    
    override func didMove(to view: SKView) {
        // 2
        backgroundColor = SKColor.white
        
        addPlayer()
        addButtons()
    }
    
    func addPlayer() {
        var placement = Int(arc4random_uniform(3) + 1)
        
        while(placement == currentPlacement) {
            placement = Int(arc4random_uniform(3) + 1)
        }
        
        currentPlacement = placement
        
        if(placement == 2) {
            chicken.position = CGPoint(x: size.width * 0.15, y: size.height * 0.9)
            chickenPosition = "left"
        } else if (placement == 1) {
            chicken.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
            chickenPosition = "mid"
        } else {
            chicken.position = CGPoint(x: size.width * 0.85, y: size.height * 0.9)
            chickenPosition = "right"
        }
        
        addChild(chicken)

    }
    
    func addButtons() {
        //left
        Circle1.position = CGPoint(x: size.width * 0.15, y: size.height * 0.1)
        Circle1.fillColor = SKColor.blue
        addChild(Circle1)
        
        //mid
        Circle2.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        Circle2.fillColor = SKColor.red
        addChild(Circle2)
        
        //right
        Circle3.position = CGPoint(x: size.width * 0.85, y: size.height * 0.1)
        Circle3.fillColor = SKColor.green
        addChild(Circle3)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            // detect touch in the scene
            let location = touch.location(in: self)
            let leftPosition = CGPoint(x: size.width * 0.33, y: size.width * 0.2)
            let midPosition = CGPoint(x: size.width * 0.66, y: size.width * 0.2)
            var touchPosition = ""
            
            if(location.x <= leftPosition.x) {
                touchPosition = "left"
            } else if (location.x <= midPosition.x) {
                touchPosition = "mid"
            } else {
                touchPosition = "right"
            }
            
            // check if circlenode has been touched
            if (self.Circle1.contains(location) && touchPosition == chickenPosition)  {
                chicken.removeFromParent()
                addPlayer()
            }
            
            if (self.Circle2.contains(location) && touchPosition == chickenPosition)  {
                chicken.removeFromParent()
                addPlayer()
            }
            
            if (self.Circle3.contains(location) && touchPosition == chickenPosition)  {
                chicken.removeFromParent()
                addPlayer()
            }

        }
    }
}
