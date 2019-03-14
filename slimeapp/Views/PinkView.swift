//
//  PinkView.swift
//  slimeapp
//
//  Created by Jess Chandler on 3/11/19.
// GNU GPL 3.0
//

import Foundation
import UIKit

class PinkView: UIView {
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
        backgroundColor = UIColor.purple
        let w = Double.random(in: 5.0...50.0)
        let x = Double.random(in: 0.0...200.0)
        let y = Double.random(in: 10.0...100.0)
        let dimen = CGRect(x: x,y: y,width: w,height: w)
        frame = dimen
        //self.frame(forAlignmentRect: dimen)
        //self.init(frame: dimen)
        self.asCircle()
    }
}
