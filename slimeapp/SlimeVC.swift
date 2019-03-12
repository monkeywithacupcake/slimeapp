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
    var oneDrop = DropView()
    var twoDrop = DropView()
    var animator: UIDynamicAnimator?

    // MARK: - Lifecycle
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = UIColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createFallingObject()
    }

    func createFallingObject() {

        //remove square from superview
        oneDrop.removeFromSuperview()

        //create the shape
        var dimen = CGRect(x: 130,y: 25,width: 90,height: 90)
        oneDrop = DropView(frame: dimen)
        oneDrop.asCircle()
        dimen = CGRect(x: 30,y: 5,width: 30,height: 40)
        twoDrop = DropView(frame: dimen)

        //then add to the screen
        self.view.addSubview(oneDrop)
        self.view.addSubview(twoDrop)

        //Initialize the animator
        animator = UIDynamicAnimator(referenceView: self.view)

        //Add gravity to the squares
        let gravity = UIGravityBehavior(items: [oneDrop, twoDrop])
        let direction = CGVector(dx: 0.0, dy: 0.05)
        gravity.gravityDirection = direction

        //Collision
        let boundaries = UICollisionBehavior(items: [oneDrop, twoDrop])
        boundaries.translatesReferenceBoundsIntoBoundary = true

        //Elasticity
        let bounce = UIDynamicItemBehavior(items: [oneDrop, twoDrop])
        bounce.elasticity = 0.3

        animator?.addBehavior(boundaries)
        animator?.addBehavior(bounce)
        animator?.addBehavior(gravity)
    }


}

