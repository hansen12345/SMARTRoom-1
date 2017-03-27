
//
//  test.swift
//  Final306Project
//
//  Created by Alex Hansen on 3/21/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import Foundation
import UIKit

class TestClass: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var onOff: UISwitch!
    @IBOutlet weak var onOffLabel: UILabel!
    


    func postItemsON() {
        let url =  "http://192.168.99.34/postToDatabase.php"
        let myUrl = NSURL(string: url)
        var request = URLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        let bodyData = "data=ON"
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
        }
        
        task.resume()
    }

    func postItemsOff() {
        let url =  "http://192.168.99.34/offToDatabase.php"
        let myUrl = NSURL(string: url)
        var request = URLRequest(url:myUrl! as URL)
        request.httpMethod = "POST"
        let bodyData = "data=OFF"
        request.httpBody = bodyData.data(using:String.Encoding.utf8);
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
        }
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
    

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
        
        
        
        
        
        
        
        }
    }

