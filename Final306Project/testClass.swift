//

//  test.swift

//  Final306Project

//

//  Created by Alex Hansen on 3/21/17.

//  Copyright © 2017 PNGapps. All rights reserved.

//


import Foundation
import UIKit
import SwiftyJSON

class TestClass: UIViewController {
    
    let myUrlData:String = "http://52.24.214.101/NewDataRoom.php"
    var roomsArray = [[String]]()
    
    @IBOutlet weak var onOff: UISwitch!
    @IBOutlet weak var onOffLabel: UILabel!
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJsonFromUrl()
        /*
        //created NSURL
        let requestURL = NSURL(string: myUrlData)
        
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "GET"
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            //exiting if there is some error
            if error != nil{
                print("error is \(error)")
                return;
            }
            do {
                //converting resonse to NSDictionary
                var teamJSON: NSDictionary!
                teamJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //getting the JSON array teams from the response
                let teams: NSArray = teamJSON["Component"] as! NSArray
                let numberOfRows = teams.count
                
                for row in 1...numberOfRows {
                    var Room = "comp"
                    Room += "\(row)"
                    var counter = 0
                    
                    let id = teams[counter][Room]["customer_id"].string as String!
                    if (id == "\(1)") {
                        let arrayName = teams[counter][Room]["room_name"].string as String!
                        let array1 = teams[counter][Room]["component_name"].string as String!
                        let array2 = teams[counter][Room]["component_status"].string as String!
                        
                        roomsArray.append([arrayName!, array1!, array2!])
                    }
                    counter += 1
                }
                print("!!!!!room \(self.roomsArray)")
                /*
                //looping through all the json objects in the array teams
                for i in 1 ..< teams.count{
                    
                    //getting the data at each index
                    let teamId:Int = teams[i]["id"] as! Int!
                    let teamName:String = teams[i]["name"] as! String!
                    let teamMember:Int = teams[i]["member"] as! Int!
                    
                    //displaying the data
                    print("id -> ", teamId)
                    print("name -> ", teamName)
                    print("member -> ", teamMember)
                    print("===================")
                    print("")
                    
                }*/
                
            } catch {
                print(error)
            }
        }
        //executing the task
        task.resume()
        */
        
    }
    //this function is fetching the json from URL
    func getJsonFromUrl(){
        //creating a NSURL
        let url = NSURL(string: myUrlData)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj!.value(forKey: "Component")!)
                
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
                self.testLabel.text = self.roomsArray[0][1]
                
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
        //for custID, roomnName, roomID, compName, compStatus in roomsArray{
            //appending the names to label
        
        //}
    }

    func postItemsOff() {
        
        let myUrl = NSURL(string: "http://52.24.214.101/postToDatabase.php")
        var request = URLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let postString = "status=OFF&room=6"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("status code is \(httpStatus.statusCode)")
                print("repsonse = \(response)")
            }
            if let dataString = NSString(data:data!, encoding:String.Encoding.utf8.rawValue){
                print(dataString)
            }
        }
        task.resume()
        print (task)
    }
    
    func postToDatabase() {
        
        let myUrl = NSURL(string: "http://52.24.214.101/postToDatabase.php")
        var request = URLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let postString = "status=ON&room=6"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil
            {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("status code is \(httpStatus.statusCode)")
                print("repsonse = \(response)")
            }
            if let dataString = NSString(data:data!, encoding:String.Encoding.utf8.rawValue){
                print(dataString)
            }
        }
        task.resume()
        print (task)
    }
    /*
     var data = NSMutableData()
     func startConnection(){
     let urlPath: String = "52.24.214.101/buttonStatus.php"
     let url: NSURL = NSURL(string: urlPath)!
     let request: NSURLRequest = NSURLRequest(url: url as URL)
     
     let connection: NSURLConnection = NSURLConnection(request: request as URLRequest, delegate: self, startImmediately: false)!
     connection.start()
     }
     func connectionDidFinishLoading(connection: NSURLConnection!) {
     var err: NSError
     let jsonResult: NSDictionary = JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
     print (jsonResult)
     }*/
     /*
    func getdata(){
        let theUrl = NSURL(string: "http://52.24.214.101/NewDataRoom.php")
        var request = URLRequest(url:theUrl! as URL)
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Everything isn't good")
            }
            else {
                var json = NSArray()
                var jsonFixer = NSMutableArray()
                
                let arr1 = NSArray(objects: "a", "b")
                let objArray = NSMutableArray(array: arr1)
                
                print("PAOLO \(arr1)")
                
                do {
                    //nsarray
                    json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSArray
                    //nsmutablearray
                    jsonFixer = NSMutableArray(array: json)
                    //print("\(json)")
                    
                    
                    if let swiftArray = objArray as NSArray as? [String] {
                        print("PAOLO \(swiftArray)")
                    }
                    if let swiftArray = jsonFixer as NSArray as? [String] {
                        print("PAOLO \(swiftArray)")
                    }

                    
                    /*
                    var jsonElement: NSDictionary = NSDictionary()
                    // let locations: NSMutableArray = NSMutableArray()
                    let count = jsonFixer.count - 1
                    for i in 0...count {
                        jsonElement = jsonFixer[i] as! NSDictionary
                        print(jsonElement)
                        print("-----------------------------")
                        for (key, value) in jsonElement {
                            print (key, value)
                        }
                        
                        
                        
                        
                        
                                      let location = LocationModel()
                         
                         //if no nil values
                         if let custID1 = jsonElement["customer_id"] as? String, let roomName1 = jsonElement["room_name"] as? String, let roomID1 = jsonElement["room_id"] as? String, let compName1 = jsonElement["component_name"] as? String, let compStatus1 = jsonElement["component_status"] as? String {
                         
                         
                         location.custID = custID1
                         location.room = roomName1
                         location.roomID = roomID1
                         location.compName = compName1
                         location.compStatus = compStatus1
                         
                         }
                         locations.add(location)
                         print("\(locations)")
                         }
                         
                    }*/
                }catch {
                    print ("error with Json: \(error)")
                }
            }
        }
        task.resume()
        
    }
    
    */
    @IBAction func onOffSubmit(_ sender: Any) {
        if (onOff.isOn){
            onOffLabel.text = "The Light is ON"
            postToDatabase()
            
        }
        else{
            onOffLabel.text = "The Light is off"
            postItemsOff()
        }
    }
 
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
