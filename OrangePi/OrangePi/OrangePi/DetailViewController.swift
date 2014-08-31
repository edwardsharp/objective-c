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
    
    @IBOutlet weak var debugLabelShort: UILabel!
    @IBOutlet var debugLabelLong: [UILabel]!
    
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

    // managed core data objects stuffz
    //this does not really work...
//    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
//    var orangePi: OrangePi? = nil
    
    
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
        if let button = connectButton { button.enabled = true }
        
        //        nameTextField.delegate = self
        //        addressTextField.delegate = self
        if let nameDelegate = nameTextField         { nameDelegate.delegate = self }
        if let nameDelegate = addressTextField      { nameDelegate.delegate = self }
        if let nameDelegate = portTextField         { nameDelegate.delegate = self }
        if let nameDelegate = usernameTextField     { nameDelegate.delegate = self }
        if let nameDelegate = passwordTextField     { nameDelegate.delegate = self }
        
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
        
        println("GOT TEXT: "+textField.text)
        println("GOT TAG: "+String(textField.tag))
        println("should be title:"+self.title)
        let tag = textField.tag
        switch tag {
        case 1:
            //name
            detailItem?.setValue(textField.text, forKey: "name")
            break
        case 2:
            //address
            detailItem?.setValue(textField.text, forKey: "address")
            break
        case 3:
    
            if let number = textField.text.toInt() {
                println("Got the port: \(number)")
                detailItem?.setValue(number, forKey: "port")
            } else {
                println("Couldn't convert port text to a number")
                detailItem?.setValue(22, forKey: "port")
            }

            break
        case 4:
            //username
            detailItem?.setValue(textField.text, forKey: "username")
            break
        case 5:
            //password
            detailItem?.setValue(textField.text, forKey: "password")
            break
        default:
            break
        }
        
        
        //gotta do this sort of thing
        //if let nameDelegate = passwordTextField     { nameDelegate.delegate = self }
//        var error: NSError? = nil
//        if !detailItem.save(&error) {
//            println("saved!")
//        }
//       
//        //hmm wish this were using the model object correctly...
        //shdahdskjahskfhdfsjdhkdhfdkjhfakdjshfakdjhfsakdkfjdkjh
        //is my xcdatata model foobarrr'dddd?????
        //if let deet: AnyObject = detailItem { deet.saveContext() }
        
        if let aDelegate: AppDelegate = UIApplication.sharedApplication().delegate as? AppDelegate { aDelegate.coredatahelper.saveContext() }
        
        
        /*
let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
let context: NSManagedObjectContext = appDelegate.managedObjectContext
let entityName: String = "OrangePi"
let myEntityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: context)
var myObject = MyObject(entity: myEntityDescription, insertIntoManagedObjectContext: context)
*/

        println("GOT textFieldShouldEndEditing & managedObjectContext?.save(nil)!")

//        if !textField.text.isEmpty{
//            //show the test buttion, i guess...
//            connectButton.enabled = true
//            //if let button = connectButton { button.enabled = true }
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

