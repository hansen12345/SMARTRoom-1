
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
<<<<<<< HEAD
=======

>>>>>>> origin/master

class TestClass: UIViewController {
   
    @IBOutlet weak var onOff: UISwitch!
    @IBOutlet weak var onOffLabel: UILabel!
    
    var componentArray = ["ON"]
    
    @IBAction func submit(_ sender: Any) {
        if (onOff.isOn) {
            componentArray[0] = "ON"
        } else {
            componentArray[0] = "OFF"
        }
        print(componentArray)
        
        do {
            // get the documents folder url
            let documentDirectoryURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            // create the destination url for the text file to be saved
            let fileDestinationUrl = documentDirectoryURL.appendingPathComponent("newResults.json")
            
            ///Users/Paolo/Desktop/iOS Projects/Final306Project/SMARTRoom/Final306Project/
            print("FilePath: \(fileDestinationUrl.path)")
            
            let text = componentArray[0]
            do {
                // writing to disk
                try text.write(to: fileDestinationUrl, atomically: false, encoding: .utf8)
                
                // saving was successful. any code posterior code goes here
                // reading from disk
                do {
                    let mytext = try String(contentsOf: fileDestinationUrl)
                    print(mytext)   // "some text\n"
                } catch let error as NSError {
                    print("error loading contentsOf url \(fileDestinationUrl)")
                    print(error.localizedDescription)
                }
            } catch let error as NSError {
                print("error writing to url \(fileDestinationUrl)")
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print("error getting documentDirectoryURL")
            print(error.localizedDescription)
        }
        
        /*
        let filename = "newResults"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let fileURL = DocumentDirURL.appendingPathComponent(filename).appendingPathExtension("json")
        
        print("FilePath: \(fileURL.path)")
        let writeString = componentArray[0]
        
        do {
            try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to url: \(fileURL), error: " + error.localizedDescription)
        }
        var readString = ""
        do {
            readString = try String(contentsOf: fileURL)
        } catch let error as NSError {
            print("Failed writing to url: \(fileURL), error: " + error.localizedDescription)
        }
        print("File Text: \(readString)")
        
        
        //File location
        let fileURLProject = Bundle.main.path(forResource: "newResults", ofType: "json")
        
        //Reading from the file
        var readStringProject = ""
        do {
            readStringProject = try String(contentsOfFile: fileURLProject!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to url: \(fileURL), error: " + error.localizedDescription)
        }*/
        
        //print(readStringProject)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
<<<<<<< HEAD


    func postItemsOff() {
        let myUrl = NSURL(string: "http://52.24.214.101/postToDatabase.php")
=======
    /**func postItemsON() {
        let url =  "http://192.168.99.34/postToDatabase.php"
        let myUrl = NSURL(string: url)
>>>>>>> origin/master
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
<<<<<<< HEAD

    func postToDatabase() {
        let myUrl = NSURL(string: "http://52.24.214.101/postToDatabase.php")
=======
    func postItemsOff() {
        let url =  "http://192.168.99.34/offToDatabase.php"
        let myUrl = NSURL(string: url)
>>>>>>> origin/master
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
<<<<<<< HEAD
      task.resume()
        print (task)
    
    }



    @IBAction func onOffSwitch(_ sender: Any) {
        if (onOff.isOn){
            onOffLabel.text = "The light is on"
            postToDatabase()
        }

        else{
            onOffLabel.text = "the Light is off"
            postItemsOff()
        }
        }




=======
        task.resume()
        }
        func onOffSwitch(_ sender: Any) {
            if(onOff.isOn){
                onOffLabel.text = " The Power is On!"
                 postItemsON()
            }
            else{
                onOffLabel.text = " The power is off :("
                postItemsOff()
            }
        }*/
>>>>>>> origin/master

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
<<<<<<< HEAD
    
        
        
        }

        
        }

        
=======
    }
}
>>>>>>> origin/master

