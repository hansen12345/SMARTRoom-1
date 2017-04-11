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
    let myUrlData:String = "http://52.24.214.101/NewDataRoom.php"
    var roomsArray = [[String]]()
    
    var numberOfRows = 0
    var roomInt = Int()
    var roomInt2 = Int()
    var finalArray = [String]()
    var listArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
    }
    
    func parseJSON() {
        //creating a NSURL
        let passInt = 1
        let url = NSURL(string: myUrlData)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                //print(jsonObj!.value(forKey: "Component")!)
                
                //getting the avengers tag array from json and converting it to NSArray
                if let heroeArray = jsonObj!.value(forKey: "Component") as? NSArray {
                    //looping through all the elements
                    for heroe in heroeArray{
                        
                        //converting the element to a dictionary
                        if let heroeDict = heroe as? NSDictionary {
                            
                            //getting the name from the dictionary
                            if let custID = heroeDict.value(forKey: "customer_id"), let roomName = heroeDict.value(forKey: "room_name"), let roomID = heroeDict.value(forKey: "room_id"), let compName = heroeDict.value(forKey: "component_name"), let compStatus = heroeDict.value(forKey: "component_status") {
                                
                                //adding the name to the array
                                self.roomsArray.append([(custID as? String)!,(roomName as? String)!,(roomID as? String)!,(compName as? String)!,(compStatus as? String)!])
                            }
                            
                        }
                    }
                }
                
                //print(self.roomsArray)
                let counter = self.roomsArray.count-1
                for i in 0...counter {
                    if ("\(passInt)" == self.roomsArray[i][0] as String) {
                        self.finalArray.append(self.roomsArray[i][1])
                    }
                }
                self.finalArray = self.removeDuplicates(array: self.finalArray)
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    self.showNames()
                })
            }
            
        }).resume()
    }
    
    func showNames(){
        //looing through all the elements of the array
        for roomName in finalArray{
            
            //appending the names to label
            listArray.append(roomName)
            
            print("ROOMS \(listArray)")
        }
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
        print("TEST 2")
        
        return listArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        //print(indexPath.row)
        print("TEST 1")
        cell.textLabel?.text = listArray[indexPath.row]
        
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
