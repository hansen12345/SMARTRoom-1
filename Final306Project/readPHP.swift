//
//  readPHP.swift
//  
//
//  Created by Paolo Garcia  on 4/4/17.
//
//

import Foundation

protocol readPHPProtocal: class {
    func itemsDownloaded(item: NSArray)
}

class readPHP: NSObject, URLSessionDataDelegate {
    
    weak var delegate : readPHPProtocal!
    var data : NSMutableData = NSMutableData()
    let urlPath: String = "http://52.24.214.101/NewDataRoom.php"
    
    func downloadItems() {
        print("6")
        let url : NSURL = NSURL(string: urlPath)!
        var session : URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url as URL)
        task.resume()
        
        
    }
    /*
    func NSURLSession(session: URLSession, dataTask: URLSessionDataTask, didRecieveData data: NSData) {
        print("7")
        self.data.append(data as Data);
       
    }*/
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print ("failed to download data")
            
        } else {
            print("data download")
            self.parseJSON()
        }
    }
    
    func parseJSON() {
        var jsonFixer: NSArray = NSArray()
        var jsonResults: NSMutableArray = NSMutableArray()
        print("test1")
        do {
            print("test2")
            jsonFixer = try JSONSerialization.jsonObject(with: self.data as Data, options: .allowFragments) as! NSArray
            
            print("test5")
            jsonResults = NSMutableArray(array: jsonFixer)
            print("test4")
        } catch let error as NSError {
            print("test3")
            print(error)
        }
        var jsonElement: NSDictionary = NSDictionary()
        
        let locations: NSMutableArray = NSMutableArray()
        
        for i in 0...jsonResults.count {
            jsonElement = jsonResults[i] as! NSDictionary
            print(jsonElement)
            
            
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
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.itemsDownloaded(item: locations)
        })
    }
}
