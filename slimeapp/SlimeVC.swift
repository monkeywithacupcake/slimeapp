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
    var dropTimer: Timer!
    var drops = [DropView]()
    var animator: UIDynamicAnimator?

    // MARK: - Lifecycle
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = UIColor.black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dropTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createAndAnimate), userInfo: nil, repeats: true)

        createDrops()
        animateObjects(a: drops)
    }

    override func viewWillDisappear(_ animated: Bool) {
        dropTimer.invalidate()
    }

    @objc func createAndAnimate(){
        createDrops()
        animateObjects(a: drops)
    }

    func createDrops(){
        for _ in 1...10 {
            drops.append(DropView())
        }
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


}

