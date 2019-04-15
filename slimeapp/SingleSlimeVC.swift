//
//  SingleSlimeVC.swift
//  slimeapp
//
//  Created by Jess Chandler on 3/11/19.
//  GNU GPL v3.0
//

import UIKit
import CoreMotion


class SingleSlimeVC: UIViewController {

    // MARK: - Properties
    var slime: ContainedView?
    //var grow = true
    //var checkTimer: Timer!
    var box: UIView?
    var animator: UIDynamicAnimator?
    var motionManager = CMMotionManager()
    var dd = CGVector(dx: CGFloat.random(in: 0.01...0.2), dy: CGFloat.random(in: 0.01...0.2))
    var gravity = UIGravityBehavior()
    var boundaries = UICollisionBehavior()
    var bounce = UIDynamicItemBehavior()

    // MARK: - Lifecycle
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = UIColor.black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //Initialize the animator
        animator = UIDynamicAnimator(referenceView: box!)
        animateSlime()
        //checkTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkStatus), userInfo: nil, repeats: true)

        if motionManager.isDeviceMotionAvailable {
            updateMotion()
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }


//    @objc func checkStatus(){
//        if (slime?.bounds.width)! > CGFloat(90.0) {
//            grow = false
//        } else if (slime?.bounds.width)! < CGFloat(10.0) {
//            grow = true
//        }
//        if grow == true {
//            slime?.changeSize(mult: 1.1)
//        } else {
//            slime?.changeSize(mult: 0.9)
//        }
//        if(animator?.isRunning == true){
//            print("animator is running")
//            //print(animator!.items(in: box?.bounds ?? view.frame))
//        }
//        else {
//            print("NOT RUNNING")
//            animator?.removeAllBehaviors()
//            dd = CGVector(dx: (1-(dd.dx)), dy:(1-(dd.dy)))
//            updateAnimation()
//        }
//
//    }

    @objc func updateAnimation(){
        //Gravity
        gravity = UIGravityBehavior(items: [slime!])
        gravity.gravityDirection = dd
        //CGVector(dx: CGFloat.random(in: 0.01...1.0), dy: CGFloat.random(in: 0.01...1.0))
        //gravity.angle = CGFloat.random(in: 0.01...0.5)
        print("current gravity", gravity.gravityDirection.dx, gravity.gravityDirection.dy)

        //Collision
        boundaries = UICollisionBehavior(items: [slime!])
        boundaries.translatesReferenceBoundsIntoBoundary = true

        //Elasticity
        bounce = UIDynamicItemBehavior(items: [slime!])
        bounce.elasticity = 0.3


        animator?.addBehavior(boundaries)
        animator?.addBehavior(bounce)
        animator?.addBehavior(gravity)
    }

    func setupView(){
        // create a box view in the center of the screen
        box = UIView()
        //box?.layer.borderColor = UIColor.blue.cgColor
        //box?.layer.borderWidth = 10
        //box?.layer.masksToBounds = true
        //box?.backgroundColor = UIColor.white
        box?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(box!)
        box!.heightAnchor.constraint(equalToConstant: 400).isActive = true
        box!.widthAnchor.constraint(equalToConstant: 300).isActive = true
        box!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        box!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        // put the slime inside the box

        slime = ContainedView()
        box!.addSubview(slime!)
    }

    func animateSlime(){

        //Gravity
        gravity = UIGravityBehavior(items: [slime!])
        //let direction = CGVector(dx: CGFloat.random(in: 0.01...0.2), dy: CGFloat.random(in: 0.01...0.2))
        //dd = direction
        gravity.gravityDirection = dd
        //gravity.angle = CGFloat.random(in: 0.01...0.5)

        //Collision
        boundaries = UICollisionBehavior(items: [slime!])
        boundaries.translatesReferenceBoundsIntoBoundary = true

        //Elasticity
        bounce = UIDynamicItemBehavior(items: [slime!])
        bounce.elasticity = 0.3
        bounce.friction = 0.5
        bounce.resistance = 0.0


        animator?.addBehavior(boundaries)
        animator?.addBehavior(bounce)
        animator?.addBehavior(gravity)

    }

    func updateMotion() {
        motionManager.deviceMotionUpdateInterval = 0.2
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
            self.gravity.gravityDirection = CGVector(dx: CGFloat((motion?.gravity.x)!), dy: CGFloat((motion?.gravity.y)!))
        }
    }
}

