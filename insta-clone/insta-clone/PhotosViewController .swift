//
//  ViewController.swift
//  insta-clone
//
//  Created by Focus on 1/28/16.
//  Copyright © 2016 Danyal Rizvi. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts : [NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
//                            NSLog("response: \(responseDictionary)")
                            self.posts = responseDictionary["data"] as! [NSDictionary]
                            self.tableView.reloadData()
                    }
                }
        
        });
        task.resume()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        if let posts = posts{
            return posts.count
        }
        else{
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoCell
        let post = posts![indexPath.row]
        let images = (post["images"] as! NSDictionary)
        let url = (images["standard_resolution"] as! NSDictionary)["url"] as! String
        let photoURL = NSURL(string: url)
       
        cell.photoView.setImageWithURL(photoURL!)
        
        return cell
    }
    
    func tableView(tableView: UITableView,
        viewForHeaderInSection section: Int) -> UIView?{
            
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        let post = posts![indexPath.section]
        let user = (post["user"] as! NSDictionary)
        let userphotoURL = user["profile_picture"] as! String
        let photoURL = NSURL(string: userphotoURL)

         profileView.setImageWithURL(userphotoURL)
        
        headerView.addSubview(profileView)
        
        // Add a UILabel for the username here
        
        return headerView
    }

    func tableView(tableView: UITableView,
    estimatedHeightForHeaderInSection section: Int) -> CGFloat{
    return 20
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let posts = posts{
            return posts.count
        }
        else{
            return 0
        }
    }

    func numberOfRowsInSection(tableView: UITableView) -> Int {
        return 1
    }
    
}

