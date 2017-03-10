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
    
    override init(size: CGSize) {
        
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        let gameover = SKSpriteNode(imageNamed: "gameover")
        gameover.position = CGPoint(x: size.width/2, y: size.height/1.3)
        addChild(gameover)
        
        let button = SKSpriteNode(imageNamed: "restartbutton")
        button.position = CGPoint(x: size.width/2, y: size.height/2.5)
        addChild(button)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
