//
//  ViewController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 7/21/16.
//  Copyright © 2016 Jacob Virgin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //INITIALIZERS
    
    enum Tier: String {
        case Voice2Voice
        case Face2Face
        case Proposal
        case Contract
    }
    
    
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var SalespersonField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var tierSwitch: UISwitch!
    
    
    var selectedCompany: NSDictionary = [:]
    
    
    @IBAction func Search(sender: AnyObject) {
        getCompany()
            if self.selectedCompany["company_number"] != nil {
                self.companyNameField.text = self.selectedCompany["company_name"] as? String
            }
            if self.selectedCompany["phone_number"] != nil {
                self.phoneNumberField.text = self.selectedCompany["phone_number"] as? String
            }
            print(self.selectedCompany["company_name"])
            print(self.selectedCompany["phone_number"])
            
        
        
    }
    
    
    @IBAction func Submit(sender: AnyObject) {
        submitCompany("", HTTPRequest: "POST", tier: Tier.Voice2Voice)
        
    }
    
    @IBAction func MoveUpTier(sender: AnyObject) {
        label.hidden = true
        let param = selectedCompany["_id"] as? String
        var tier = Tier.Voice2Voice
        if selectedCompany["tier"] != nil {
            tier = convertToTier(selectedCompany["tier"] as! String)
        }
        tier = moveUpTier(tier)
        
        submitCompany(param!, HTTPRequest: "PUT", tier: tier)
        
        
    }
    
    @IBAction func Update(sender: AnyObject) {
        var param = ""
        if selectedCompany["_id"] != nil {
            param = (selectedCompany["_id"] as? String)!
        }
        var tier = Tier.Voice2Voice
        if selectedCompany["tier"] != nil {
         tier = convertToTier(selectedCompany["tier"] as! String)
        }
        submitCompany(param, HTTPRequest: "PUT", tier: tier)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.hidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getCompany() {
        label.hidden = true
        let sendValue = companyNameField.text
        
        var param = ""
        
        if sendValue != nil {
            
            param = (sendValue?.stringByReplacingOccurrencesOfString(" ", withString: "%20"))!
        }
        
        let scriptUrl = "http://localhost:3000/api/companies/"
        
        let urlWithParams = scriptUrl + param
        
        let finalUrl = NSURL(string: urlWithParams)
        
        let request = NSMutableURLRequest(URL: finalUrl!)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {data, response, error in
            
            if error != nil {
                print("error=\(error)")
                self.companyNameField.text = "The request did not return anything. Try something else!"
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("response string is \(responseString)")
            print(self.selectedCompany)
            do {
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary{
                    if convertedJsonIntoDict["companies"] != nil {
                        if let myArray = convertedJsonIntoDict["companies"] as? NSArray {
                            if myArray.count > 0 {
                                self.selectedCompany = (myArray[0] as? NSDictionary)!
                                print(self.selectedCompany)
                                
                            } else {
                                self.label.text = "Nothing there bitch"
                                self.label.hidden = false
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
    
    
    func submitCompany(params: String, HTTPRequest: String, tier: Tier){
        label.hidden = true
        
        let scriptUrl = "http://localhost:3000/api/companies/\(params)"
        
        print(scriptUrl)
        
        var bodyData: [String: AnyObject] = [:]
        
        if companyNameField.text != nil {
            bodyData["company_name"] = companyNameField.text
        }
        if phoneNumberField.text != nil {
            bodyData["phone_number"] = phoneNumberField.text
        }
        
            bodyData["tier"] = tier.rawValue
        
        
        
        if SalespersonField.text != nil {
            bodyData["salesperson"] = SalespersonField.text
        }
        
        bodyData["_id"] = selectedCompany["_id"]
        
        
        print(bodyData)
        
        let finalUrl = NSURL(string: scriptUrl)
        
        let request = NSMutableURLRequest(URL: finalUrl!)
        
        
        request.HTTPMethod = HTTPRequest
        
        
        print(request.HTTPMethod)
        
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
            companyNameField.text = ""
            phoneNumberField.text = ""
            SalespersonField.text = ""
            
        }
        
    }
    
    
    func moveUpTier(tier: Tier) -> Tier {
        switch tier {
        case Tier.Voice2Voice: return Tier.Face2Face
        case Tier.Face2Face: return Tier.Proposal
        case Tier.Proposal: return Tier.Contract
        default: return Tier.Voice2Voice
            
        }
    }
    
    func convertToTier(tier: String) -> Tier{
        switch tier {
        case "Voice2Voice" : return Tier.Voice2Voice
        case "Face2Face": return Tier.Face2Face
        case "Proposal": return Tier.Proposal
        case "Contract": return Tier.Contract
        default: return Tier.Voice2Voice
        }
    }
    
    
    
}

