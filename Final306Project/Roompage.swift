//
//  Roompage.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 1/19/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import UIKit
import SwiftyJSON

class RoomPage: UITableViewController {
    
    var numberOfRows = 0
    var roomsArray = [String]()
    var roomInt = Int()
    var roomInt2 = Int()
    var finalArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJSON()
    }
    
    func parseJSON() {
        let path : String = Bundle.main.path(forResource: "newResults", ofType: "json") as String!
        let roomData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: roomData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        
        numberOfRows = readableJSON[].count
        roomInt2 = 1
        print("# of rows \(numberOfRows)")
        for i in 0...numberOfRows {
            
            var Room = "comp"
            var nextRoom = "comp"
            Room += "\(i)"
            nextRoom += "\(i+1)"
            
            var roomCount = 0
            
            let emID = readableJSON["Component"][roomCount]["customer_id"].string as String!
            //let hasComponents = readableJSON["Component"][roomCount]["room_name"].string as String!
            
            
            if (emID == "\(roomInt2)") {
                roomInt = roomInt2
                let rooms = readableJSON["Component"][roomCount]["room_name"].string as String!
                
                roomsArray.append(rooms!)
                finalArray = removeDuplicates(array: roomsArray)
                print("ROOMS FOR THE COMP\(finalArray)")
            }
            roomCount += 1
        }
        print("ROOMS FOR THE COMP\(finalArray)")
    }
    
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return finalArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        //print(indexPath.row)
        cell.textLabel?.text = finalArray[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let index = indexPath?.row
        let myVC = segue.destination as! oneRoompage
        myVC.intPassed = index!
        myVC.emID = roomInt2
        NSLog("YO \(myVC.intPassed)")
        
    }

}
