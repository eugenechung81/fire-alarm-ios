//
//  RoomImageViewController.swift
//  FireDetection
//
//  Created by DAVID MAIMAN on 1/31/16.
//  Copyright © 2016 IPShack. All rights reserved.
//

import UIKit
class RoomImageViewController : UIViewController{
    
    @IBOutlet var imageURL : UIImageView!
    @IBOutlet var lblImageRoomName : UILabel!
    var room : RoomObject!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.title = room.room_id
        self.navigationItem.hidesBackButton = true
        //Load live imag from the server
        if let url = NSURL(string: "http://192.241.182.68:5000/images/" + room.room_id + ".png") {
            if let data = NSData(contentsOfURL: url) {
                imageURL.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func backButton(){
        self.navigationController!.popViewControllerAnimated(true)
    }
}