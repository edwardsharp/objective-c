//
//  ButtonCollectionViewCell.swift
//  OrangeSeq
//
//  Created by edward on 8/25/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    //@IBOutlet var imageView: UIImageView!
    //probably need @IBOutelet var button: UIButton!
    
    @IBOutlet weak var genericButton: CircularButtonDesign!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
}
