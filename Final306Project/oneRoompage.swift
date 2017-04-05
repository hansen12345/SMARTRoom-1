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
    
    
    @IBOutlet var roomName: UILabel!
    
    //switches for components
    @IBOutlet var switch1: UISwitch!
    @IBOutlet var switch2: UISwitch!
    @IBOutlet var switch3: UISwitch!
    @IBOutlet var switch4: UISwitch!
    @IBOutlet var switch5: UISwitch!
    
    //Label for components
    @IBOutlet var comp1: UILabel!
    @IBOutlet var comp2: UILabel!
    @IBOutlet var comp3: UILabel!
    @IBOutlet var comp4: UILabel!
    @IBOutlet var comp5: UILabel!
    
    
    //Consumption output
    @IBOutlet var output1: UILabel!
    @IBOutlet var output2: UILabel!
    @IBOutlet var output3: UILabel!
    @IBOutlet var output4: UILabel!
    @IBOutlet var output5: UILabel!
    
    var numberOfRows = 0
    let myUrlData:String = "http://52.24.214.101/NewDataRoom.php"
    var roomsArray = [[String]]()
    var finalArray = [[String]]()
    //DATA TEST
    var intPassed = Int()
    var emID = 1
    
    
    
    
    @IBAction func defaultRoom(_ sender: Any) {
        
        switch1.setOn(false, animated: true)
        switch2.setOn(false, animated: true)
        switch3.setOn(false, animated: true)
        switch4.setOn(false, animated: true)
        switch5.setOn(false, animated: true)
       
        if (switch1.isOn) {
            roomsArray[intPassed][1] = "ON"
            if (roomsArray.count >= 2) {
                if (switch2.isOn) {
                    roomsArray[intPassed][2] = "ON"
                    if (roomsArray.count >= 3) {
                        if (switch3.isOn) {
                            roomsArray[intPassed][3] = "ON"
                            if (roomsArray.count >= 4) {
                                if (switch4.isOn) {
                                    roomsArray[intPassed][4] = "ON"
                                    if (roomsArray.count >= 5) {
                                        if (switch5.isOn) {
                                            roomsArray[intPassed][5] = "ON"
                                        } else {
                                            roomsArray[intPassed][5] = "OFF"
                                        }
                                    }
                                } else {
                                    roomsArray[intPassed][4] = "OFF"
                                    
                                }
                            }
                        } else {
                            roomsArray[intPassed][3] = "OFF"
                            
                        }
                    }
                    
                } else {
                    roomsArray[intPassed][2] = "OFF"
                    
                }
            }
        } else {
            roomsArray[intPassed][1] = "OFF"
            
        }
        
        
        
        //print(roomsArray)
    }
    
    @IBAction func submitDataButton(_ sender: Any) {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!
        
        var jsonFilePath = documentsDirectoryPath.appendingPathComponent("results.json")
        let fileManager = FileManager.default
        var isDirectory: ObjCBool = false
        
        // creating a .json file in the Documents folder
        if !fileManager.fileExists(atPath: (jsonFilePath?.absoluteString)!, isDirectory: &isDirectory) {
            let created = fileManager.createFile(atPath: (jsonFilePath?.absoluteString)!, contents: nil, attributes: nil)
            if created {
                print("File created ")
            } else {
                print("Couldn't create file for some reason")
            }
        } else {
            print("File already exists")
        }
        
        if (switch1.isOn) {
            roomsArray[intPassed][2] = "ON"
            if (roomsArray.count >= 2) {
                if (switch2.isOn) {
                    roomsArray[intPassed][2] = "ON"
                    if (roomsArray.count >= 3) {
                        if (switch3.isOn) {
                            roomsArray[intPassed][2] = "ON"
                            if (roomsArray.count >= 4) {
                                if (switch4.isOn) {
                                    roomsArray[intPassed][2] = "ON"
                                    if (roomsArray.count >= 5) {
                                        if (switch5.isOn) {
                                            roomsArray[intPassed][2] = "ON"
                                        } else {
                                            roomsArray[intPassed][2] = "OFF"
                                        }
                                    }
                                } else {
                                    roomsArray[intPassed][2] = "OFF"
                                    
                                }
                            }
                        } else {
                            roomsArray[intPassed][2] = "OFF"
                            
                        }
                    }

                } else {
                    roomsArray[intPassed][2] = "OFF"
                    
                }
            }
        } else {
            roomsArray[intPassed][2] = "OFF"
            
        }
        
        
        
        //print(roomsArray)
        
        /* creating an array of test data
        var newRoomArray = [String]()
        for i in 0 ..< 100 {
            newRoomArray.append("Test\(i)")
        }*/
        
        // creating JSON out of the above array
        var jsonData: NSData!
        do {
            jsonData = try JSONSerialization.data(withJSONObject: roomsArray, options: JSONSerialization.WritingOptions()) as NSData!
            let jsonString = String(data: jsonData as Data, encoding: String.Encoding.utf8)
            NSLog(jsonString!)
        } catch let error as NSError {
            print("Array to JSON conversion failed: \(error.localizedDescription)")
        }
        
        // Write that JSON to the file created earlier
        jsonFilePath = documentsDirectoryPath.appendingPathComponent("results.json")
        do {
            let file = try FileHandle(forWritingTo: jsonFilePath!)
            file.write(jsonData as Data)
            print("JSON data was written to the file successfully!")
        } catch let error as NSError {
            print("Couldn't write to file: \(error.localizedDescription)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DATA TEST
        NSLog("!!!!!!!!!!!!!!!!!!!!\(intPassed)")
        self.comp3.isHidden = true
        self.comp4.isHidden = true
        self.comp5.isHidden = true
        
        self.switch3.isHidden = true
        self.switch4.isHidden = true
        self.switch5.isHidden = true
        
        self.output2.isHidden = true
        self.output3.isHidden = true
        self.output4.isHidden = true
        self.output5.isHidden = true
        
        parseJSON()
    }
    
    func parseJSON() {
        //creating a NSURL
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
                print(self.roomsArray)
                let counter = self.roomsArray.count-1
                
                for i in 0...counter {
                    if ("\(self.emID)" == self.roomsArray[0][0] as String) {
                        self.roomName.text = self.roomsArray[0][1]
                        self.comp1.text = self.roomsArray[0][3]
                        if (self.roomsArray[i][4] == "ON") {
                            self.switch1.setOn(true, animated: true)
                        } else {
                            self.switch1.setOn(false, animated: true)
                        }
                        if(counter >= 2) {
                            self.comp2.text = self.roomsArray[1][3]
                            if (self.roomsArray[1][4] == "ON") {
                              self.switch2.setOn(true, animated: true)
                            } else {
                                self.switch2.setOn(false, animated: true)
                            }
                        }
                    }
                
                
                        
                }
                
                OperationQueue.main.addOperation({
                    //calling another function after fetching the json
                    //it will show the names to label
                    
                })
            }
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
