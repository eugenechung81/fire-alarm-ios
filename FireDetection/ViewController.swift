//
//  ViewController.swift
//  FireDetection
//
//  Created by DAVID MAIMAN on 1/30/16.
//  Copyright © 2016 IPShack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableRooms: UITableView!
    @IBOutlet var imageSpinner: UIActivityIndicatorView!
    var roomObjects: [RoomObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startSpinning()
        // Do any additional setup after loading the view, typically from a nib.
        let url : String = "http://192.241.182.68:5000/statuses"
        let request : NSMutableURLRequest = NSMutableURLRequest()
        let queue:NSOperationQueue = NSOperationQueue()
        request.URL = NSURL(string: url)
        request.HTTPMethod = "GET"
        self.tableRooms.hidden = true
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            do{
                
                let jsonResult: NSMutableArray = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers) as! NSMutableArray
                
                
                let datastring = NSString(data:data!, encoding:NSUTF8StringEncoding) as! String
                NSLog(datastring)
                for var i = 0; i < jsonResult.count; ++i {
                    let room : RoomObject = RoomObject(input: jsonResult[i] as! NSMutableDictionary)
                    self.roomObjects.append(room)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableRooms.reloadData()
                }
            }
            catch {
                
            }
            
        })
        
        task.resume()
        
    }
    func startSpinning() {
        imageSpinner.startAnimating()
    }
    
    func stopSpinning() {
        imageSpinner.stopAnimating()
        imageSpinner.hidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomObjects.count+1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.item > 0 {
            stopSpinning()
            self.tableRooms.hidden = false
            let cell = tableRooms.dequeueReusableCellWithIdentifier("RoomDetailRow") as! RoomDetailRow
            let roomObj = roomObjects[indexPath.item-1]
            cell.numberOccupents!.text = String(roomObj.occupancy)
            cell.roomName!.text = roomObj.room_id
            if roomObj.status == "NORMAL"{
                cell.imageFire!.hidden = true
            }
            if !roomObj.carbonDetected{
                cell.imageCO!.hidden = true
            }
            
            return cell
        }
        else{
            let cell = tableRooms.dequeueReusableCellWithIdentifier("HeaderRow") as! HeaderRow
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}

