//
//  TryMazeVC.swift
//  slimeapp
//
//  Created by Jess Chandler on 4/13/19.
//  Copyright © 2019 MAJIK PRODUCTIONS. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class TryMazeVC: UIViewController {



    override func viewDidLoad() {
        super.viewDidLoad()

        let sceneView = SKView()
        self.view = sceneView
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
