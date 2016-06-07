//
//  CustomAlert.swift
//  RedditReader
//
//  Created by Janmarc on 6/6/16.
//  Copyright © 2016 Janmarc. All rights reserved.
//

import Foundation
import UIKit

class CustomAlert {
    
    
    func alert(view: UIViewController) {
        let alert = UIAlertController(title: "Nothing Found", message: "Search again", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        view.navigationController?.popToRootViewControllerAnimated(true)
        view.presentViewController(alert, animated: true, completion: nil)
    }

}
