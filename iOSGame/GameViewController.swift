//
//  GameViewController.swift
//  iOSGame
//
//  Created by Kevin Tieu on 2017-02-09.
//  Copyright © 2017 Kevin Tieu. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



class GameViewController: UIViewController {

    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    var timer = Timer()
    var counter = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats:true)
    }
    
    func update() {
        if (counter > -1) {
            countLabel.text = "Time: " + String(counter)
            counter -= 1
        } else {
            timer.invalidate()
            countLabel.text = ""
            let skView = self.view as! SKView
            let reveal = SKTransition.fade(with: UIColor.white, duration: 3)
            let gameOverScene = GameOverScene(size: view.bounds.size)
            skView.presentScene(gameOverScene, transition: reveal)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
