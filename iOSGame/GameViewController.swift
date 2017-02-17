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

    @IBOutlet weak var countLabel: UILabel!
    var timer = Timer()
    var counter = 30

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
            countLabel.text = String(counter)
            counter -= 1
        } else {
            timer.invalidate()
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    


}
