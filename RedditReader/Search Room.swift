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
//        self.title = "Search"
        self.searchButton.backgroundColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        self.navigationController?.topViewController?.title = "Search"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.backgroundColor = UIColor.blueColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        searchButton.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)

        
    }
    
    var room: String = ""

    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField.text = ""
        self.searchButton.enabled = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text?.characters.count > 0 {
            self.searchButton.enabled = true
        } else {
            self.searchButton.enabled = false
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