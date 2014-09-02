//
//  CmdViewController.swift
//  OrangePi
//
//  Created by edward on 8/31/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

class CmdViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var cmdTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // #PRAGMA MARK - UITextFieldDelegate methods
    func textFieldDidBeginEditing(textField: UITextField!) {
        println("GOT textFieldDidBeginEditing!")
    }
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {
        
        println("GOT TEXT: "+textField.text)
        println("GOT TAG: "+String(textField.tag))
        println("should be title:"+self.title)
//        let tag = textField.tag
//        switch tag {
//        case 1:
//            //name
//            break
//        default:
//            break
//        }

        
        
        return true
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        println("GOT textFieldShouldReturn!")
        textField.resignFirstResponder()
        return true
    }
    //end UITextFieldDelegate methods

}
