//
//  ViewController.swift
//  OrangeSeq
//
//  Created by edward on 8/24/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var width = 320.0
    var height = 560.0
    
    var buttons = [String]()
    
    @IBOutlet var roundButtonGesture: UILongPressGestureRecognizer!
    
    @IBOutlet weak var xVal: UILabel!
    
    @IBOutlet weak var yVal: UILabel!
    
    
    @IBOutlet weak var aSwitch: UISwitch!
    
    
    @IBOutlet weak var roundButton: CircularButtonDesign!
    
    @IBAction func roundButtonTouchDown() {
        defaultButtonTouchDown(roundButton)
    }
    
    @IBAction func roundButtonTouchUpInside() {
        defaultButtonTouchUp(roundButton, aSwitch: aSwitch)
    }
    
    @IBAction func roundButtonGestureAction(sender: UILongPressGestureRecognizer) {
        //#TODO: figure point out where touch ends
        defaultButtonGestureAction(sender, button: roundButton)
        
    }
    
    
    // THERE'S GONNA BE A LOT OF THESE...
    @IBOutlet weak var button1xProgressView: UIProgressView!
    @IBOutlet weak var button1yProgressView: UIProgressView!
    @IBAction func bank1TouchDown(sender: AnyObject) {
        defaultButtonTouchUp(bank1button1, aSwitch: bank1switch1)
    }
    @IBAction func bank1TouchUp() {
        defaultButtonTouchDown(bank1button1)
    }
    @IBOutlet var bank1button1RefGestureRecognizer: UILongPressGestureRecognizer!

    @IBOutlet weak var bank1button1: CircularButtonDesign!
    
    @IBOutlet weak var bank1switch1: UISwitch!
    
    @IBAction func bank1button1RefGestureAction(sender: UILongPressGestureRecognizer) {
        defaultButtonGestureAction(sender, button: bank1button1)
    }
    
    //MARK - CollectionView stuffz
    
    
    
    
    // MARK - DEFAULT BUTTON ACTIONS
    func defaultButtonTouchUp(button: UIButton, aSwitch: UISwitch){
        button.backgroundColor = UIColor.clearColor()
        aSwitch.setOn(!aSwitch.on, animated:true)
    }
    
    func defaultButtonTouchDown(button: UIButton){
        button.backgroundColor = UIColor.orangeColor()
    }
    
    func defaultButtonGestureAction(sender: UILongPressGestureRecognizer, button: UIButton){
        
//        if sender.isEqual(roundButtonGesture){
        if sender.state == UIGestureRecognizerState.Began {
            button.backgroundColor = UIColor.redColor()
            println("GOT UIGestureRecognizerState.Began!!")
        }else if sender.state == UIGestureRecognizerState.Changed {
            
            button.backgroundColor = UIColor.redColor()
            let xV = sender.locationOfTouch(0, inView: self.view).x
            let yV = sender.locationOfTouch(0, inView: self.view).y
            
            button1xProgressView.progress = Float(Double(xV) / width)
            button1yProgressView.progress = Float(Double(yV) / height)
            
            xVal.text = xV.description
            yVal.text = yV.description
            
            println("GOT UIGestureRecognizerState.Chaged!! X:" + xV.description )
            println(" Y:" + yV.description )
            
        }else if sender.state == UIGestureRecognizerState.Ended {
            println("GOT UIGestureRecognizerState.Ended!!")
            button.backgroundColor = UIColor.clearColor()
        }
//        }
    }

//    minimumPressDuration = 1.0f;
//    allowableMovement = 100.0f;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setYProgressViewRot()
        //CGAffineTransformMakeRotation( CGFloat(M_PI * 0.5))
        //CATransform3DMakeRotation(3.14/3, 0.0, 0.0, 1.0)
        var sizeRect = UIScreen.mainScreen().applicationFrame;
        width = Double(sizeRect.size.width)
        height = Double(sizeRect.size.height)
        
        
        buttons = ["one", "two", "three", "four", "five", "six"]
    }

    func setYProgressViewRot(){
        //90-degree hack! (GETTIN HOT IN HURR)
       // button1yProgressView.transform = CGAffineTransformMakeRotation( CGFloat(M_PI * 0.5))
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

    //PRAGMA MARK - CollectionView stuffz
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return buttons.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as ButtonCollectionViewCell
        //buttons[indexPath.row]
        return cell
    }

}

