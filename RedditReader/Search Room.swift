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


    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        searchButton.enabled = false
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text?.characters.count > 0 {
            self.searchButton.enabled = true
        }
        return true
    }
    @IBAction func goButton(sender: AnyObject) {
        textField.delegate = self
        room = self.textField.text!
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as? ViewController
        vc?.room = room
        
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    


}