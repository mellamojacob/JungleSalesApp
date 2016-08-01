//
//  UserController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 7/29/16.
//  Copyright © 2016 Jacob Virgin. All rights reserved.
//

import Foundation
import UIKit

class UserController: UIViewController {
    
    enum Tier: String {
        case Voice2Voice
        case Face2Face
        case Proposal
        case Contract
    }
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func submitUserButtonPressed(sender: AnyObject) {
        label.hidden = true
        let scriptUrl = "http://localhost:3000/api/users"
        
        print(scriptUrl)
        
        var bodyData: [String: AnyObject] = [:]
        
        if userNameField.text != nil {
            bodyData["user_name"] = userNameField.text
        }
        if phoneNumberField.text != nil {
            bodyData["phone_number"] = phoneNumberField.text
        }
        if emailField.text != nil {
            bodyData["email"] = emailField.text
        }
        
        
        print(bodyData)
        
        let finalUrl = NSURL(string: scriptUrl)
        
        let request = NSMutableURLRequest(URL: finalUrl!)
        
        
        request.HTTPMethod = "POST"
        
        
        
        let valid = NSJSONSerialization.isValidJSONObject(bodyData)
        
        do{
            if valid {
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(bodyData, options: NSJSONWritingOptions.PrettyPrinted)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            }
            
            
        } catch let error as NSError{
            self.label.text = "request could not be parsed \(error)"
            self.label.hidden = false
        }
        
        print(request)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                self.label.text = "Session failed"
                self.label.hidden = false
                return
            }
        }
        
        task.resume()
        
        
        if label.hidden {
            label.text = "Completed!"
            label.hidden = false
            userNameField.text = ""
            phoneNumberField.text = ""
            emailField.text = ""
            
        }
        
    }
    
    
    @IBOutlet weak var companyField: UITextField!
    
    @IBAction func AddCompanyButtonPressed(sender: AnyObject) {
        if userNameField.text != nil || companyField.text != nil {
            
            
            
        }
    }
    
    
}

















































