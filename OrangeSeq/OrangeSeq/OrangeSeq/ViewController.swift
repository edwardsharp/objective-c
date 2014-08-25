//
//  ViewController.swift
//  OrangeSeq
//
//  Created by edward on 8/24/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
                            
    @IBOutlet var roundButtonGesture: UILongPressGestureRecognizer!
    
    @IBOutlet weak var xVal: UILabel!
    
    @IBOutlet weak var yVal: UILabel!
    
    
    @IBOutlet weak var aSwitch: UISwitch!
    
    @IBOutlet weak var roundButton: CircularButtonDesign!
    
    @IBAction func roundButtonTouchDown() {
        roundButton.backgroundColor = UIColor.orangeColor()
    }
    
    @IBAction func roundButtonTouchUpInside() {
        roundButton.backgroundColor = UIColor.clearColor()
        aSwitch.setOn(!aSwitch.on, animated:true)
    }
    
    @IBAction func roundButtonGestureAction(sender: UILongPressGestureRecognizer) {
        //#TODO: figure point out where touch ends
        if sender.isEqual(roundButtonGesture){
            if sender.state == UIGestureRecognizerState.Began {
                roundButton.backgroundColor = UIColor.redColor()
                println("GOT UIGestureRecognizerState.Began!!")
            }else if sender.state == UIGestureRecognizerState.Changed {
                
                roundButton.backgroundColor = UIColor.redColor()
                
                xVal.text = sender.locationOfTouch(0, inView: self.view).x.description
                yVal.text = sender.locationOfTouch(0, inView: self.view).y.description
                
                println("GOT UIGestureRecognizerState.Chaged!! X:" + sender.locationOfTouch(0, inView: self.view).x.description )
                println(" Y:" + sender.locationOfTouch(0, inView: self.view).y.description )
                
            }else if sender.state == UIGestureRecognizerState.Ended {
                println("GOT UIGestureRecognizerState.Ended!!")
                roundButton.backgroundColor = UIColor.clearColor()
            }
        }

    }
    

//    minimumPressDuration = 1.0f;
//    allowableMovement = 100.0f;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    //this will report every touch on the view...
//    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
//        // do your stuff
//        println("GOT touchesBegan! event"+event.description)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

