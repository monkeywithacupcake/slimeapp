//
//  DropView.swift
//  slimeapp
//
//  Created by Jess Chandler on 3/11/19.
// GNU GPL 3.0
//

import Foundation
import UIKit

class DropView: UIView {
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.randomColor()
    }
}
