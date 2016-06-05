//
//  ViewController.swift
//  RedditReader
//
//  Created by Janmarc on 6/4/16.
//  Copyright © 2016 Janmarc. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableViewArray = NSMutableArray()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - LifeCylcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        
        Alamofire.request(.GET, "https://www.reddit.com/r/pictures.json", parameters: nil)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    
                    let data = JSON["data"] as? NSDictionary
                    let children = data!["children"] as? NSMutableArray
                    
                    self.tableViewArray = children!
              
                    
                    
                    self.tableView.reloadData()
                    
                    print("TABLE VIEW ARRAY: \(self.tableViewArray)")
                    
//                  print("JSON: \(JSON)")
//                  print("THIS IS THE CHILDEN ARRAY: ", JSON["data"]!!["children"]  )
                }
        }
    }
    
    //MARK: - TableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NO OF ROWS COUNTED")
        return tableViewArray.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell")! as! CustomCell
        print("var tableView DECLARED")
        
        let dictionary = self.tableViewArray[indexPath.row]
        let data = dictionary["data"] as? NSDictionary
        
        let scoreInt = data!["score"] as! Int
        let scoreString = String(scoreInt)
        
        cell.pointsLabel?.text = scoreString
        cell.titleLabel?.text = data!["title"] as? String
        cell.userLabel?.text = data!["author"] as? String
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = self.tableViewArray[indexPath.row]
        let data = dictionary["data"] as? NSDictionary
        let url = data!["url"] as! String
        
        print("URL: ", url)
        
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        
        
        
    }
    

}

