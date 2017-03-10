//
//  GameOverScene.swift
//  iOSGame
//
//  Created by Kevin Tieu on 2017-02-17.
//  Copyright © 2017 Kevin Tieu. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    let button = SKSpriteNode(imageNamed: "restartbutton")
    let gameover = SKSpriteNode(imageNamed: "gameover")
    let background = SKSpriteNode(imageNamed: "dark-background.jpg") // background image in the gameover scene
    var score : SKLabelNode!
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.zPosition = 1
        addChild(background)

        gameover.position = CGPoint(x: size.width/2, y: size.height/1.3)
        gameover.zPosition = 2
        addChild(gameover)
        
        button.position = CGPoint(x: size.width/2, y: size.height/2.3)
        button.zPosition = 2
        addChild(button)
        
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "myKey")
        score = SKLabelNode(fontNamed: "Helvetica")
        score.text = "Best Score: " + token!
        score.fontSize = 30
        score.fontColor = SKColor.white
        score.position = CGPoint(x: size.width/2 , y: size.height/5.0) // score on the top-left corner
        score.zPosition = 2
        addChild(score)
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let location = touch.location(in: self)
            
            // detect touch on button
            if(self.button.contains(location)) {
                let gameScene = GameScene(size: self.size)
                let skView = self.view
                
                gameScene.scaleMode = SKSceneScaleMode.aspectFill
                gameScene.reset()
                skView?.presentScene(gameScene)
            }
        }
    }
}
