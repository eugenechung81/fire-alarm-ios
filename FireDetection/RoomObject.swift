//
//  RoomObject.swift
//  FireDetection
//
//  Created by DAVID MAIMAN on 1/30/16.
//  Copyright © 2016 IPShack. All rights reserved.
//

import Foundation

class RoomObject : NSObject {
    var status : String = "fdsa"
    var room_id : String = "room"
    
    var occupancy : Int = -1
    var carbonDetected : Bool = false
    
    init( input: NSMutableDictionary){
        if let stat = input["status"] as? String{
            status = stat
        }
        if let room = input["room_id"] as? String{
            room_id = room
        }
        if let occ = input["occupancy"] as? Int{
            occupancy = occ
        }
        if let carb = input["carbon_detected"] as? Bool{
            carbonDetected = carb
        }
    }
    
}