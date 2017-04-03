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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBOutlet weak var onOff: UISwitch!
    @IBOutlet weak var onOffLabel: UILabel!
    
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
