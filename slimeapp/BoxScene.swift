//
//  BoxScene.swift
//  slimeapp
//
//  Created by Jess Chandler on 4/13/19.
//  Copyright © 2019 MAJIK PRODUCTIONS. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class BoxScene: SKScene, SKPhysicsContactDelegate {

    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var col: Int = 1

    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self

        player = self.childNode(withName: "player") as! SKSpriteNode

        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (Data, error) in

            self.physicsWorld.gravity = CGVector(dx: CGFloat((Data?.acceleration.x)!) * 15, dy: CGFloat((Data?.acceleration.y)!) * 15)
        }

    }

    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB

        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1 {
            var a = Int(arc4random_uniform(9) + 1)
            if col == a && a != 9{
                a = a + 1
            } else if col == a && a == 9 {
                a = 1
            }
            col = a


        }

    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
