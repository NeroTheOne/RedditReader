//
//  ViewController.swift
//  RedditReader
//
//  Created by Janmarc on 6/4/16.
//  Copyright © 2016 Janmarc. All rights reserved.
//

import UIKit
import Alamofire
import DGElasticPullToRefresh

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableViewArray = NSMutableArray()
    var tableView: UITableView!
    
//    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - LifeCylcle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.delegate = self
        refreshAnimation()
    }
    
    //MARK: - TableView Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NO OF ROWS COUNTED")
        return tableViewArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomCell
        print("var tableView DECLARED")
        
        let dictionary = self.tableViewArray[indexPath.row]
        let data = dictionary["data"] as? NSDictionary
        
        let scoreInt = data!["score"] as! Int
        let scoreString = String(scoreInt)
        
        cell.pointsLabel?.text = scoreString
        cell.titleLabel.text = data!["title"] as? String
        cell.userLabel.text = data!["author"] as? String
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dictionary = self.tableViewArray[indexPath.row]
        let data = dictionary["data"] as? NSDictionary
        let url = data!["url"] as! String
        
        print("URL: ", url)
        
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
    }
    
    
    func Runalmofire(completion: (success: String) -> Void) {
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
                    completion(success: "Complete")
                    
                    print("TABLE VIEW ARRAY: \(self.tableViewArray)")
                    
                    //                  print("JSON: \(JSON)")
                    //                  print("THIS IS THE CHILDEN ARRAY: ", JSON["data"]!!["children"]  )
                }
        }
    }
    
    func refreshAnimation() {
        tableView.dataSource = self
        tableView.delegate = self
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self!.Runalmofire({ (success) in
                self?.tableView.dg_stopLoading()
            })
            
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    override func loadView() {
        super.loadView()
        
        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 90
        tableView.registerNib(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        tableView.separatorColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 231/255.0, alpha: 1.0)
        tableView.backgroundColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 251/255.0, alpha: 1.0)
        view.addSubview(tableView)
    }
    

    
}

