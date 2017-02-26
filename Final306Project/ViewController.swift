//
//  ViewController.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 1/18/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation


class ViewController: UIViewController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBOutlet var UN: UITextField!
    @IBOutlet var PW: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        let URL_login = "Http://192.168.99.163/SMARTRoom.php"
        let requestURL = NSURL(string: URL_login)
        let request = NSMutableURLRequest(url: requestURL as! URL)
        request.httpMethod = "POST"
        let userNAME = UN.text
        let passWORD = PW.text
        let postParameters = "Username=" + userNAME! + "& Password=" + passWORD!;
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
            do{
                let myJSON = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any]
                if let parseJSON = myJSON {
                    var msg : String!
                    msg = parseJSON["message"] as! String?
                    print(msg)
                }
            } catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
}




