//
//  CircularSlideDesign.swift
//  OrangeSeq
//
//  Created by edward on 8/24/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

@IBDesignable class CircularSlideDesign: UIView {
    @IBInspectable var borderColor: UIColor = UIColor.clearColor(){
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
