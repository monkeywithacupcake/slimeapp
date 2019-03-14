//
//  SlimeVC.swift
//  slimeapp
//
//  Created by Jess Chandler on 3/11/19.
//  GNU GPL v3.0
//

import UIKit

class SlimeVC: UIViewController {

    // MARK: - Properties
    //var oneDrop = DropView()
    //var twoDrop = DropView()
    var drops = [DropView]()
    var pinks = [PinkView]()
    var mores = [DropView]()
    var animator: UIDynamicAnimator?

    // MARK: - Lifecycle
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = UIColor.black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createDrops()
        //createFallingObjects()
        //animateObjects(a: pinks)
        animateObjects(a: mores)
    }



    func createDrops(){
        //drops = [DropView(),DropView(),DropView(),DropView(),DropView()]
        //pinks = [PinkView(),PinkView(),PinkView()]
        for _ in 1...400 {
            mores.append(DropView())
        }
        //mores = [DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView(),DropView()]
    }
    func animateObjects(a: [UIView]){
        a.forEach { ad in
            ad.removeFromSuperview()
            self.view.addSubview(ad)
        }

        //Initialize the animator
        animator = UIDynamicAnimator(referenceView: self.view)

        //Gravity
        let gravity = UIGravityBehavior(items: a)
        let direction = CGVector(dx: CGFloat.random(in: 0.01...0.2), dy: CGFloat.random(in: 0.01...0.2))
        gravity.gravityDirection = direction
        gravity.angle = CGFloat.random(in: 0.01...0.5)

        //Collision
        let boundaries = UICollisionBehavior(items: a)
        boundaries.translatesReferenceBoundsIntoBoundary = true

        //Elasticity
        let bounce = UIDynamicItemBehavior(items: a)
        bounce.elasticity = CGFloat.random(in: 0.3...1.0)

        // Push
        let pushes = UIPushBehavior(items: a, mode: .continuous)
        pushes.pushDirection = CGVector(dx: CGFloat.random(in: 0.0...1.0), dy: CGFloat.random(in: 0.0...1.0))

        animator?.addBehavior(boundaries)
        animator?.addBehavior(bounce)
        animator?.addBehavior(gravity)
        animator?.addBehavior(pushes)
    }

    func createFallingObjects() {
        drops.forEach { d in
            d.removeFromSuperview()
            self.view.addSubview(d)
        }

        //Initialize the animator
        animator = UIDynamicAnimator(referenceView: self.view)

        //Gravity
        let gravity = UIGravityBehavior(items: drops)
        let direction = CGVector(dx: 0.07, dy: 0.05)
        gravity.gravityDirection = direction

        //Collision
        let boundaries = UICollisionBehavior(items: drops)
        boundaries.translatesReferenceBoundsIntoBoundary = true

        //Elasticity
        let bounce = UIDynamicItemBehavior(items: drops)
        bounce.elasticity = CGFloat.random(in: 0.0...1.0)
        //func addLinearVelocity(_ velocity: CGPoint, for item: UIDynamicItem)



        animator?.addBehavior(boundaries)
        animator?.addBehavior(bounce)
        animator?.addBehavior(gravity)
    }


}

