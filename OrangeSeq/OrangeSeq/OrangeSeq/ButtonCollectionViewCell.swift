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
    
    //var genericButton: CircularButtonDesign!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
//        let button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
//        button.frame = CGRectMake(100, 100, 100, 50)
//        button.backgroundColor = UIColor.greenColor()
//        button.setTitle("Test Button", forState: UIControlState.Normal)
//        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        self.addSubview(button)
        
//        var label: UILabel = UILabel()
//        label.frame = CGRectMake(50, 50, 200, 21)
//        label.backgroundColor = UIColor.blackColor()
//        label.textColor = UIColor.whiteColor()
//        label.textAlignment = NSTextAlignment.Center
//        label.text = "test label"
//        self.addSubview(label)

    }
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
}



/*




var txtField: UITextField = UITextField()
txtField.frame = CGRectMake(50, 70, 200, 30)
txtField.backgroundColor = UIColor.grayColor()
self.view.addSubview(txtField)
return self;*/