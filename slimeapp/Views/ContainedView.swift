//
//  ContainedView.swift
//  slimeapp
//
//  Created by Jess Chandler on 3/11/19.
// GNU GPL 3.0
//

import Foundation
import UIKit

class ContainedView: UIView {
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()

    }

    //init required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView() {
        backgroundColor = UIColor.red
        let w = 20.0
        let x = 0.0
        let y = 0.0
        let dimen = CGRect(x: x,y: y,width: w,height: w)
        bounds = dimen
        self.frame = bounds
        //self.frame(forAlignmentRect: dimen)
        //self.init(frame: dimen)
        self.asCircle()
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.spanSuperView()
    }

    public func changeSize(mult: CGFloat) {
        let w = mult*self.bounds.height
        self.frame = CGRect(x: 0.0, y: 0.0, width: w, height: w)
        self.asCircle()
    }
}
