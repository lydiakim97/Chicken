//
//  GameScene.swift
//  iOSGame
//
//  Created by Kevin Tieu on 2017-02-09.
//  Copyright © 2017 Kevin Tieu. All rights reserved.
//

import SpriteKit
import GameplayKit

var score: Int = 0
var myLabel: SKLabelNode!

class GameScene: SKScene {
    
    var chicken = SKSpriteNode(imageNamed: "chicken-2")
    var chickenPosition = ""
    let Circle1 = SKSpriteNode(imageNamed: "barn")
    let Circle2 = SKSpriteNode(imageNamed: "barn")
    let Circle3 = SKSpriteNode(imageNamed: "barn")

    var arrayChickens:[SKSpriteNode] = []
    var arrayPositions:[String] = []
    let numberOfChickens = 5
    
    override func didMove(to view: SKView) {
        /*let bgImage = SKSpriteNode(imageNamed: "background.jpg")
         self.addChild(bgImage)*/
        backgroundColor = UIColor.white
        initChicken()
        addButtons()
        initScore()
    }

    // shows the friggin score
    func initScore() {
        myLabel = SKLabelNode(fontNamed: "Helvetica")
        myLabel.text = "Score: 0"
        myLabel.fontSize = 20
        myLabel.fontColor = SKColor.black
        myLabel.position = CGPoint(x: size.width / 2, y: size.height * 0.05)
        addChild(myLabel)
    }
    
    /* Creates 5 instances of a chicken and add them to the chickens array */
    func initChicken() {
        for i in 0..<numberOfChickens {
            chicken = SKSpriteNode(imageNamed: "chicken-2")
            
            let placement = Int(arc4random_uniform(100)%3)

            if(placement == 0) {
                chicken.position = CGPoint(x: size.width * 0.145, y: (size.height * 0.25 + CGFloat(i) * size.height * 0.15))
                chickenPosition = "left"
            } else if (placement == 1) {
                chicken.position = CGPoint(x: size.width * 0.5, y: (size.height * 0.25 + CGFloat(i) * size.height * 0.15))
                chickenPosition = "mid"
            } else {
                chicken.position = CGPoint(x: size.width * 0.855, y: (size.height * 0.25 + CGFloat(i) * size.height * 0.15))
                chickenPosition = "right"
            }
            
            arrayChickens.append(chicken)
            arrayPositions.append(chickenPosition)
            addChild(chicken)

        }
    }
    

    func addChicken() {
        // Adds chicken to last index of arrayChicken
        chicken = SKSpriteNode(imageNamed: "chicken-2")
        let placement = Int(arc4random_uniform(100)%3)
        
        if(placement == 2) {
            chicken.position = CGPoint(x: size.width * 0.145, y: (size.height * 0.25 + 5 * size.height * 0.15))
            chickenPosition = "left"
        } else if (placement == 1) {
            chicken.position = CGPoint(x: size.width * 0.5, y: (size.height * 0.25 + 5 * size.height * 0.15))
            chickenPosition = "mid"
        } else {
            chicken.position = CGPoint(x: size.width * 0.855, y: (size.height * 0.25 + 5 * size.height * 0.15))
            chickenPosition = "right"
        }
        
        arrayChickens[4] = chicken
        arrayPositions[4] = chickenPosition
        
        addChild(chicken)

    }
    
    func moveDown() {
        arrayChickens[0].removeFromParent() // remove the chicken in the first row
        for i in 0..<numberOfChickens {
            if (i != 4) {
                arrayPositions[i] = arrayPositions[i+1]
                arrayChickens[i] = arrayChickens[i+1]
            }
        }
        addChicken()

        for i in 0..<numberOfChickens {
            //arrayChickens[i].position = CGPoint(x: arrayChickens[i].position.x, y: arrayChickens[i].position.y - size.height * 0.15)
            let moveDownAction = SKAction.moveBy(x: 0, y: -size.height * 0.15, duration:0.2)
            let moveDownSequence = SKAction.sequence([moveDownAction])
            arrayChickens[i].run(moveDownSequence)
        }
        score += 1
        myLabel.text = "Score: \(score)"
    }
    
    
    func addButtons() {
        //left
        Circle1.position = CGPoint(x: size.width * 0.15, y: size.height * 0.13)
        addChild(Circle1)
        
        //mid
        Circle2.position = CGPoint(x: size.width * 0.5, y: size.height * 0.13)
        addChild(Circle2)
        
        //right
        Circle3.position = CGPoint(x: size.width * 0.85, y: size.height * 0.13)
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
            
            // check if circle node has been touched
            if (self.Circle1.contains(location) && touchPosition == arrayPositions[0]
                || (self.Circle2.contains(location) && touchPosition == arrayPositions[0])
                || (self.Circle3.contains(location) && touchPosition == arrayPositions[0]))  {
                moveDown()
            } else {
                let jumpUpAction = SKAction.moveBy(x: 0, y:20, duration:0.2)
                let jumpDownAction = SKAction.moveBy(x: 0, y:-20, duration:0.2)
                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
                arrayChickens[0].run(jumpSequence)
            }
        }
    }

}
