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
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        let message = "Game Over"
        
        let label = SKLabelNode(fontNamed: "Thonburi-Bold")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/1.5)
        addChild(label)
        
        button.position = CGPoint(x: size.width/2, y: size.height/2.5)
        addChild(button)
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
