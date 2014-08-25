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
    
    @IBAction func roundButtonGestureAction(sender: UILongPressGestureRecognizer) {
        //#TODO: figure point out where touch ends
        if sender.isEqual(roundButtonGesture){
            if sender.state == UIGestureRecognizerState.Began {
                println("GOT UIGestureRecognizerState.Began!!")
            }else if sender.state == UIGestureRecognizerState.Changed {
                
                println("GOT UIGestureRecognizerState.Chaged!! X:" + sender.locationOfTouch(0, inView: self.view).x.description )
                println(" Y:" + sender.locationOfTouch(0, inView: self.view).y.description )
                
            }else if sender.state == UIGestureRecognizerState.Ended {
                println("GOT UIGestureRecognizerState.Ended!!")
            }
        }

    }
    
    /*

    self.lpgr.minimumPressDuration = 1.0f;
    self.lpgr.allowableMovement = 100.0f;
    
 sender:UIRotationGestureRecognizer
    
    var lastRotation = CGFloat()
    
    self.view.bringSubviewToFront(rotateView)
    if(sender.state == UIGestureRecognizerState.Ended){
    lastRotation = 0.0;
    }
    rotation = 0.0 - (lastRotation - sender.rotation)
    var point = rotateRec.locationInView(rotateView)
    var currentTrans = sender.view.transform
    var newTrans = CGAffineTransformRotate(currentTrans, rotation)
    
    sender.view.transform = newTrans
    lastRotation = sender.rotation


    
    
    UILongPressGestureRecognizer *)sender
    {
    if ([sender isEqual:self.lpgr]) {
    if (sender.state == UIGestureRecognizerStateBegan)
    {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Gestures" message:@"Long Gesture Detected" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    }
    }


*/

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        roundButtonGesture.addTarget(self, action: "longPressedView")
        
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        // do your stuff
        println("GOT touchesBegan! event"+event.description)
    }
    
    //sender:UILongPressGestureRecognizer
    func longPressedView(){
        //#TODO: figure point out where touch ends
//        if sender.isEqual(roundButtonGesture){
//            if sender.state == UIGestureRecognizerState.Began {
//                println("GOT UIGestureRecognizerState.Began!!")
//            }else if sender.state == UIGestureRecognizerState.Changed {
//                println("GOT UIGestureRecognizerState.Chaged!!")
//            }else if sender.state == UIGestureRecognizerState.Ended {
//                println("GOT UIGestureRecognizerState.Ended!!")
//            }
//        }
        println("GOT roundButtonGesture " + String(roundButtonGesture.state.toRaw()))
        
//        let tapAlert = UIAlertController(title: "Long Pressed", message: "You just long pressed the long press view", preferredStyle: UIAlertControllerStyle.Alert)
//        tapAlert.addAction(UIAlertAction(title: "OK", style: .Destructive, handler: nil))
//        self.presentViewController(tapAlert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

