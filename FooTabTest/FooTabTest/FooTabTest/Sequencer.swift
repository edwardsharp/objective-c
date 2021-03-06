//
//  Sequencer.swift
//  FooTabTest
//
//  Created by edward on 8/18/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import Foundation

class Sequencer {
    
    typealias SequencerNext = (AnyObject? -> Void)
    typealias SequencerStep = (AnyObject?, SequencerNext) -> Void
    
    var steps: [SequencerStep]  = []
    
    func run() {
        runNextStepWithResult(nil)
    }
    
    func enqueueStep(step: SequencerStep) {
        steps.append(step)
    }
    
    func dequeueNextStep() -> (step: SequencerStep) {
        return steps.removeAtIndex(0)
    }
    
    func runNextStepWithResult(result: AnyObject?) {
        if (steps.count <= 0) {
            return
        }
        
        var step = dequeueNextStep()
        step(result, { self.runNextStepWithResult($0) })
    }
    
}