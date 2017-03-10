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
    
    var chicken = SKSpriteNode(imageNamed: "chicken")
    var chickenPosition = ""
    let Circle1 = SKSpriteNode(imageNamed: "barn")
    let Circle2 = SKSpriteNode(imageNamed: "barn")
    let Circle3 = SKSpriteNode(imageNamed: "barn")
    let background = SKSpriteNode(imageNamed: "grass-background.jpg") // background image on the gameplay
    var arrayChickens:[SKSpriteNode] = []
    var arrayPositions:[String] = []
    let numberOfChickens = 5
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = 1
        addChild(background)
        initChicken()
        addButtons()
        initScore()
    }

    // shows the friggin score
    func initScore() {
        myLabel = SKLabelNode(fontNamed: "Helvetica")
        myLabel.text = "0"
        myLabel.fontSize = 19
        myLabel.fontColor = SKColor.black
        myLabel.position = CGPoint(x: size.width * 0.055 , y: size.height * 0.945) // score on the top-left corner
        myLabel.zPosition = 2
        addChild(myLabel)
    }
    
    /* Creates 5 instances of a chicken and add them to the chickens array */
    func initChicken() {
        for i in 0..<numberOfChickens {
            chicken = SKSpriteNode(imageNamed: "chicken")
            
            let placement = Int(arc4random_uniform(100))

            if(placement <= 33) {
                chicken.position = CGPoint(x: size.width * 0.145, y: (size.height * 0.25 + CGFloat(i) * size.height * 0.15))
                chickenPosition = "left"
            } else if (placement <= 66) {
                chicken.position = CGPoint(x: size.width * 0.5, y: (size.height * 0.25 + CGFloat(i) * size.height * 0.15))
                chickenPosition = "mid"
            } else {
                chicken.position = CGPoint(x: size.width * 0.855, y: (size.height * 0.25 + CGFloat(i) * size.height * 0.15))
                chickenPosition = "right"
            }
            
            arrayChickens.append(chicken)
            arrayPositions.append(chickenPosition)
            chicken.zPosition = 2
            addChild(chicken)

        }
    }
    

    func addChicken() {
        // Adds chicken to last index of arrayChicken
        chicken = SKSpriteNode(imageNamed: "chicken")
        let placement = Int(arc4random_uniform(100))
        
        if(placement <= 33) {
            chicken.position = CGPoint(x: size.width * 0.145, y: (size.height * 0.25 + 5 * size.height * 0.15))
            chickenPosition = "left"
        } else if (placement <= 66) {
            chicken.position = CGPoint(x: size.width * 0.5, y: (size.height * 0.25 + 5 * size.height * 0.15))
            chickenPosition = "mid"
        } else {
            chicken.position = CGPoint(x: size.width * 0.855, y: (size.height * 0.25 + 5 * size.height * 0.15))
            chickenPosition = "right"
        }
        
        arrayChickens[4] = chicken
        arrayPositions[4] = chickenPosition
        
        chicken.zPosition = 2
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
            let moveDownAction = SKAction.moveBy(x: 0, y: -size.height * 0.15, duration:0.1)
            let moveDownSequence = SKAction.sequence([moveDownAction])
            arrayChickens[i].run(moveDownSequence)
        }
        score += 1
        myLabel.text = "\(score)"
    }
    
    
    func addButtons() {
        //left
        Circle1.position = CGPoint(x: size.width * 0.15, y: size.height * 0.13)
        Circle1.zPosition = 2
        addChild(Circle1)
        
        //mid
        Circle2.position = CGPoint(x: size.width * 0.5, y: size.height * 0.13)
        Circle2.zPosition = 2
        addChild(Circle2)
        
        //right
        Circle3.position = CGPoint(x: size.width * 0.85, y: size.height * 0.13)
        Circle3.zPosition = 2
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
            if (self.Circle1.contains(location) && touchPosition == arrayPositions[0])  {
                moveDown()
            } else if (self.Circle1.contains(location) && touchPosition != arrayPositions[0]) {
                let jumpUpAction = SKAction.moveBy(x: 0, y:20, duration:0.2)
                let jumpDownAction = SKAction.moveBy(x: 0, y:-20, duration:0.2)
                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
                arrayChickens[0].run(jumpSequence)
                let enable1 = SKAction.run({[unowned self] in self.Circle1.isUserInteractionEnabled = false})
                Circle1.isUserInteractionEnabled = true
                Circle1.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable1]))
                let enable2 = SKAction.run({[unowned self] in self.Circle2.isUserInteractionEnabled = false})
                Circle2.isUserInteractionEnabled = true
                Circle2.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable2]))
                let enable3 = SKAction.run({[unowned self] in self.Circle3.isUserInteractionEnabled = false})
                Circle3.isUserInteractionEnabled = true
                Circle3.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable3]))
                
            }
            
            if (self.Circle2.contains(location) && touchPosition == arrayPositions[0])  {
                moveDown()
            } else if (self.Circle2.contains(location) && touchPosition != arrayPositions[0]) {
                let jumpUpAction = SKAction.moveBy(x: 0, y:20, duration:0.2)
                let jumpDownAction = SKAction.moveBy(x: 0, y:-20, duration:0.2)
                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
                arrayChickens[0].run(jumpSequence)
                run(SKAction.wait(forDuration: TimeInterval(5)))
                let enable1 = SKAction.run({[unowned self] in self.Circle1.isUserInteractionEnabled = false})
                Circle1.isUserInteractionEnabled = true
                Circle1.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable1]))
                let enable2 = SKAction.run({[unowned self] in self.Circle2.isUserInteractionEnabled = false})
                Circle2.isUserInteractionEnabled = true
                Circle2.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable2]))
                let enable3 = SKAction.run({[unowned self] in self.Circle3.isUserInteractionEnabled = false})
                Circle3.isUserInteractionEnabled = true
                Circle3.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable3]))
            }
            
            if (self.Circle3.contains(location) && touchPosition == arrayPositions[0])  {
                moveDown()
            } else if (self.Circle3.contains(location) && touchPosition != arrayPositions[0]) {
                let jumpUpAction = SKAction.moveBy(x: 0, y:20, duration:0.2)
                let jumpDownAction = SKAction.moveBy(x: 0, y:-20, duration:0.2)
                let jumpSequence = SKAction.sequence([jumpUpAction, jumpDownAction])
                arrayChickens[0].run(jumpSequence)
                run(SKAction.wait(forDuration: TimeInterval(5)))
                let enable1 = SKAction.run({[unowned self] in self.Circle1.isUserInteractionEnabled = false})
                Circle1.isUserInteractionEnabled = true
                Circle1.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable1]))
                let enable2 = SKAction.run({[unowned self] in self.Circle2.isUserInteractionEnabled = false})
                Circle2.isUserInteractionEnabled = true
                Circle2.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable2]))
                let enable3 = SKAction.run({[unowned self] in self.Circle3.isUserInteractionEnabled = false})
                Circle3.isUserInteractionEnabled = true
                Circle3.run(SKAction.sequence([SKAction.wait(forDuration:0.4),enable3]))
            }
        }
        
    }

}
