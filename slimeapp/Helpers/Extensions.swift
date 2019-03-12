//
//  Extensions.swift
//  slimeapp
//
//  Created by Jess Chandler on 3/11/19.
//  GNU
//

import Foundation
import UIKit



extension UIView {
    func asCircle(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }

    func roundedEdges(){
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = true
    }
    func clearConstraints() {
        for subview in self.subviews {
            subview.clearConstraints()
        }
        self.removeConstraints(self.constraints)
    }

    func removeAllSubViews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    func spanSuperView(hSpace: Double = 0.0, vSpace: Double = 0.0) {
        guard superview != nil else { return }
        let v = CGFloat(vSpace)
        let h = CGFloat(hSpace)
        self.topAnchor.constraint(equalTo: superview!.topAnchor, constant: v).isActive = true
        self.bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -v).isActive = true
        self.trailingAnchor.constraint(equalTo: superview!.trailingAnchor, constant: -h).isActive = true
        self.leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: h).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func spanScreen(hSpacing: CGFloat = 0, wSpacing: CGFloat = 0) {
        if #available(iOS 11.0, *) {
            guard superview != nil else { return }
            let guide = self.superview!.safeAreaLayoutGuide
            self.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -wSpacing).isActive = true
            self.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: wSpacing).isActive = true
            self.topAnchor.constraint(equalTo: guide.topAnchor, constant: hSpacing).isActive = true
            self.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -hSpacing).isActive = true

        }
        else {
            guard superview != nil else { return }
            let margins = self.superview!.layoutMarginsGuide
            print("I have margins for less than ios 11")
            print(margins)
            self.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -wSpacing).isActive = true
            self.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: wSpacing).isActive = true
            self.topAnchor.constraint(equalTo: margins.topAnchor, constant: hSpacing+15).isActive = true
            self.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -hSpacing).isActive = true
        }
    }
    func spanToScreen() {
        guard superview != nil else { return }
        if #available(iOS 11.0, *) {
            let guide = superview!.safeAreaLayoutGuide
            self.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true

        }
        else {
            let margins = superview!.layoutMarginsGuide
            self.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        }
    }
}

extension UILabel {

    /// The receiver’s font size, including any adjustment made to fit to width. (read-only)
    ///
    /// If `adjustsFontSizeToFitWidth` is not `true`, this is just an alias for
    /// `.font.pointSize`. If it is `true`, it returns the adjusted font size.
    ///
    /// Derived from: [http://stackoverflow.com/a/28285447/5191100](http://stackoverflow.com/a/28285447/5191100)
    var fontSize: CGFloat {
        get {
            if adjustsFontSizeToFitWidth {
                var currentFont: UIFont = font
                let originalFontSize = currentFont.pointSize

                var currentSize: CGSize = (text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])
                //sizeWithAttributes([NSFontAttributeName: currentFont])

                while currentSize.width > frame.size.width && currentFont.pointSize > (originalFontSize * minimumScaleFactor) {
                    currentFont = currentFont.withSize(currentFont.pointSize - 1)
                    currentSize = (text! as NSString).size(withAttributes: [NSAttributedString.Key.font: currentFont])
                }

                return currentFont.pointSize
            }

            return font.pointSize
        }
    }
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIImage {
    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
        var width: CGFloat
        var height: CGFloat
        var newImage: UIImage

        let size = self.size
        let aspectRatio =  size.width/size.height

        switch contentMode {
        case .scaleAspectFit:
            if aspectRatio > 1 {                            // Landscape image
                width = dimension
                height = dimension / aspectRatio
            } else {                                        // Portrait image
                height = dimension
                width = dimension * aspectRatio
            }

        default:
            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
        }

        if #available(iOS 10.0, *) {
            let renderFormat = UIGraphicsImageRendererFormat.default()
            renderFormat.opaque = opaque
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
            newImage = renderer.image {
                (context) in
                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
            self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        }

        return newImage
    }
}

extension UIColor {

    func isLight() -> Bool {
        guard let components = cgColor.components, components.count > 2 else {return false}
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return (brightness > 0.5)
    }


    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))/CGFloat(255)
        let g = CGFloat(arc4random_uniform(256))/CGFloat(255)
        let b = CGFloat(arc4random_uniform(256))/CGFloat(255)
        let a = CGFloat(arc4random_uniform(256))/CGFloat(255)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIApplication {
    class func isFirstLaunch() -> Bool {
        if UserDefaults.standard.bool(forKey: "hasBeenLaunchedBeforeFlag") {
            UserDefaults.standard.set(true, forKey: "hasBeenLaunchedBeforeFlag")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
}

extension UITextView {
    func updateTextFont() {
        if (self.text.isEmpty || self.bounds.size.equalTo(CGSize.zero)) {
            return;
        }
        let textViewSize = self.frame.size;
        let fixedWidth = textViewSize.width;
        let expectSize = self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        var expectFont = self.font
        if (expectSize.height > textViewSize.height) {
            while (self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height) {
                expectFont = self.font!.withSize(self.font!.pointSize - 1)
                self.font = expectFont
            }
        }
        else {
            while (self.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height < textViewSize.height) {
                expectFont = self.font
                self.font = self.font!.withSize(self.font!.pointSize + 1)
            }
            self.font = expectFont
        }
    }
}

