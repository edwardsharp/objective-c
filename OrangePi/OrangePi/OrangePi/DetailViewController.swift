//
//  DetailViewController.swift
//  OrangePi
//
//  Created by edward on 8/23/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
                            
   

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var portTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
     @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    @IBOutlet weak var connectButton: UIButton!
    
    
//    
//    let notificationCenter = NSNotificationCenter.defaultCenter()
//    let mainQueue = NSOperationQueue.mainQueue()
//    
//    var observer = notificationCenter.addObserverForName(UITextFieldTextDidChangeNotification, object: nil, queue: mainQueue) { _ in
//        self.sendButton.enabled = self.messageField.text.utf16count > 0
//    }
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: AnyObject = detailItem {
            self.title = detail.valueForKey("name").description
            
            if let label = detailDescriptionLabel {
                label.text = detail.valueForKey("timeStampString").description
            }
            if let name = nameTextField {
                name.text = detail.valueForKey("name").description
            }
            
            //
            if let port = portTextField {
                port.text = detail.valueForKey("port").description
            }
            if let address = addressTextField {
                if detail.valueForKey("address") { address.text = detail.valueForKey("address").description }
            }
            if let username = usernameTextField {
                username.text = detail.valueForKey("username").description
            }
            if let password = passwordTextField {
                password.text = detail.valueForKey("password").description
            }
        }

        // field validation: hide the connect button
        //using `connectButton.enabled = false`  is no me gusta, yay type-safety below:
        if let button = connectButton { button.enabled = false }
        
        //        nameTextField.delegate = self
        //        addressTextField.delegate = self
        if let nameDelegate = nameTextField     { nameDelegate.delegate = self }
        if let nameDelegate = addressTextField  { nameDelegate.delegate = self }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UITextFieldDelegate methods
    func textFieldDidBeginEditing(textField: UITextField!) {
        println("GOT textFieldDidBeginEditing!")
    }
    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {
        println("GOT textFieldShouldEndEditing!")
        if !textField.text.isEmpty{
            println("GOT TEXT: "+textField.text)
            println("GOT TAG: "+String(textField.tag))
            println("SHOULD ENABLE connectButton!")
            connectButton.enabled = true
            //if let button = connectButton { button.enabled = true }
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        println("GOT textFieldShouldReturn!")
        textField.resignFirstResponder()
        if !textField.text.isEmpty{
            println("SHOULD ENABLE connectButton!")
            connectButton.enabled = true
            //if let button = connectButton { button.enabled = true }
        }
        return true
    }
    //end UITextFieldDelegate methods

}

