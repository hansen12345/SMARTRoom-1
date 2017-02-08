//
//  oneRoompage.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 2/1/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import UIKit
import SwiftyJSON

class oneRoompage: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var lampSwitch: UISwitch!
    @IBOutlet var tvSwitch: UISwitch!
    @IBOutlet var roomLightSwitch: UISwitch!
    @IBOutlet var ACUnit: UIPickerView!
    
    
    //DATA TEST
    @IBOutlet var test: UILabel!

    var numberOfRows = 0
    var roomsArray = [[String]]()
    var pickerData = [String]()
    
    @IBAction func defaultRoom(_ sender: Any) {
        
        lampSwitch.setOn(false, animated: true)
        tvSwitch.setOn(false, animated: true)
        roomLightSwitch.setOn(false, animated: true)
        ACUnit.selectRow(21, inComponent: 0, animated: true)
        
    }
    
    @IBAction func submitDataButton(_ sender: Any) {
        
        
        return
    }
    
    
    //DATA TEST
    var intPassed = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ACUnit.delegate = self
        self.ACUnit.delegate = self
        pickerData = ["45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80"]
        
        //DATA TEST
        NSLog("!!!!!!!!!!!!!!!!!!!!\(intPassed)")
        test.text = " int: \(intPassed)"
        
        parseJSON()
    }
    
    func parseJSON() {
        let path : String = Bundle.main.path(forResource: "dataRoom", ofType: "json") as String!
        let roomData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: roomData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        
        numberOfRows = readableJSON["rooms"].count
        
        for row in 1...numberOfRows {
            for col in 1...numberOfRows {
            var Room = "room"
            Room += "\(row)"
            let rooms = readableJSON["rooms"][Room]["roomNumber"].string as String!
            let lamps = readableJSON["rooms"][Room]["lamp"].string as String!
            let tvs = readableJSON["rooms"][Room]["tv"].string as String!
            let roomLights = readableJSON["rooms"][Room]["roomLight"].string as String!
            let acUnits = readableJSON["rooms"][Room]["acUnit"].string as String!
            
            NSLog("room\(row)\(col)\(lamps)\(tvs)\(roomLights)\(acUnits)")
                
            roomsArray.append([rooms!])
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
}
