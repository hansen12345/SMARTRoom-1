//
//  oneRoompage.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 2/1/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import UIKit
import SwiftyJSON

class oneRoompage: UIViewController {
    
    @IBOutlet var lampSwitch: UISwitch!
    @IBOutlet var tvSwitch: UISwitch!
    @IBOutlet var roomLightSwitch: UISwitch!
    @IBOutlet var ACUnit: UIPickerView!
    
    @IBOutlet var test: UILabel!
    
    var numberOfRows = 0
    var roomsArray = [[String]]()
    
    @IBAction func defaultRoom(_ sender: Any) {
        
        return
    }
    
    var intPassed = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test.text = " int: \(intPassed)"
        
        parseJSON()
    }
    
    func parseJSON() {
        let path : String = Bundle.main.path(forResource: "dataRoom", ofType: "json") as String!
        let roomData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: roomData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        
        numberOfRows = readableJSON["rooms"].count
        
        for i in 1...numberOfRows {
            for j in 1...numberOfRows {
            var Room = "room"
            Room += "\(i)"
            let rooms = readableJSON["rooms"][Room]["roomNumber"].string as String!
            let lamps = readableJSON["rooms"][Room]["lamp"].string as String!
            let tvs = readableJSON["rooms"][Room]["tv"].string as String!
            let roomLights = readableJSON["rooms"][Room]["roomLight"].string as String!
            let acUnits = readableJSON["rooms"][Room]["acUnit"].string as String!
            
            NSLog("\(j)\(lamps)\(tvs)\(roomLights)\(acUnits)")
                
            roomsArray.append([rooms!])
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
