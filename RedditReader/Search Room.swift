//
//  Search Room.swift
//  RedditReader
//
//  Created by Janmarc on 6/6/16.
//  Copyright © 2016 Janmarc. All rights reserved.
//

import Foundation
import UIKit

class searchRoom: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var room: String = ""

//    func searchAction() {
//        textField.delegate = self
//        room = self.textField.text!
//        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as? ViewController
//        vc?.room = room
//        
//        self.navigationController?.pushViewController(vc!, animated: true)
//    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField.text = ""
        
    }
    
    func alert() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func goButton(sender: AnyObject) {
        textField.delegate = self
        room = self.textField.text!
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as? ViewController
        vc?.room = room
        
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    


}