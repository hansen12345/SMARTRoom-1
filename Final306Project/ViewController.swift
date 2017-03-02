//
//  ViewController.swift
//  Final306Project
//
//  Created by Paolo Garcia  on 1/18/17.
//  Copyright © 2017 PNGapps. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var employeeID: UITextField!
    @IBOutlet var employeePassword: UITextField!
    
    
    var numberOfRows = 0
    var employeeArray = [String]()
    var passwordArray = [String]()
    var emID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //emID = 1
        
    }
    
    @IBAction func loginButton(_ sender: AnyObject) {
        let username = self.employeeID.text
        let password = self.employeePassword.text
        
        let path : String = Bundle.main.path(forResource: "loginUser", ofType: "json") as String!
        let loginData = NSData(contentsOfFile: path) as NSData!
        let readableJSON = JSON(data: loginData as! Data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
        
        numberOfRows = readableJSON[0].count
        print("???room\(numberOfRows)")
        for i in 1...numberOfRows {
            
            var user = "login"
            user += "\(i)"
            
            let loginID = readableJSON[0][user]["username"].string as String!
            let passwordID = readableJSON[0][user]["password"].string as String!
            
            employeeArray.append(loginID!)
            passwordArray.append(passwordID!)
        }
        NSLog("\(employeeArray)")
        NSLog("\(passwordArray)")
        NSLog("\(numberOfRows)")
        NSLog("\(username)")
        NSLog("\(password)")
        if ((username?.isEmpty)! || (password?.isEmpty)!) {
            let alertController = UIAlertController(title: "INVALID", message: "All fields are required", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
                action in
            }
            alertController.addAction(cancelAction)
            let okAction = UIAlertAction(title: "OK", style: .default) {
                action in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true) {
            }
            employeeArray.removeAll()
            passwordArray.removeAll()
            return
        }
        
        var b = 0
        while (b < numberOfRows) {
           
            if (username == employeeArray[b] && password == passwordArray[b]) {
                NSLog("LOGGED IN")
                b += 1
                emID = b
                print("EMP ID:\(emID)")
                return
            } else {
                 b += 1
            }
        }
        let alertController = UIAlertController(title: "INVALID", message: "Username and password do not match", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            action in
        }
        alertController.addAction(cancelAction)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            action in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true) {
        }
        employeeArray.removeAll()
        passwordArray.removeAll()

    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myVC = segue.destination as! RoomPage
     
        myVC.roomInt2 = emID
        NSLog("YO \(myVC.roomInt2)")
        
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


