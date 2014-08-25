//
//  ThirdViewController.swift
//  FooTabTest
//
//  Created by edward on 8/18/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var sequenceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sequenceButton.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pressed(sender: UIButton!) {
        
        
        let sequencer = Sequencer()
        sequencer.enqueueStep() { result, next in
            println("* 1st Step")
            next(0)
        }
        sequencer.enqueueStep() { result, next in
            println("* 2nd Step")
            next(result)
        }
        sequencer.enqueueStep() { result, next in
            println("* 3nd Step - Async example")
            println("Got \(result) from previous step")
            println("This step is going to do some async work...")
            let popTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, 2 * 1000);
            dispatch_after(popTime, dispatch_get_main_queue(), {
                println("finished the async work.");
                next(result);
            });
        }

        sequencer.enqueueStep() { result, next in
            println("* Final Step")
            println("Got \(result) from previous step")
            println("GONNA RESTART!")
            
        }
        sequencer.run()
    
        
        
        
//    var alertView = UIAlertView();
//    alertView.addButtonWithTitle("Ok");
//        alertView.title = "seq";
//        alertView.message = "done!";
//        alertView.show();
        
        
        
    }
    
    
}