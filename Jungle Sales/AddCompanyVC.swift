//
//  AddCompanyVC.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 1/13/17.
//  Copyright © 2017 Jacob Virgin. All rights reserved.
//
/*
import UIKit

class AddCompanyVC: UIViewController {

    
    
    @IBOutlet weak var companyNameField: UITextField!
    
    @IBOutlet weak var salespersonField: UITextField!
    
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var tierField: UITextField!
    
    @IBOutlet weak var responseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.responseLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddCompanyPressed(_ sender: Any) {
        var companyName : String = ""
        var salesperson : String = ""
        var phoneNumber : String = ""
        let startingTier = Tier.init()
        var tier : String = "\(startingTier.tierName)"
        if companyNameField.hasText {
            companyName = companyNameField.text!
        }
        if salespersonField.hasText {
            salesperson = salespersonField.text!
        }
        if phoneNumberField.hasText {
            phoneNumber = phoneNumberField.text!
        }
        if tierField.hasText {
            tier = tierField.text!
        }
        
        let bodyDictionary: [String: AnyObject] = ["company_name" : companyName as AnyObject, "phone_number" : phoneNumber as AnyObject, "tier" : tier as AnyObject, "salesperson" : salesperson as AnyObject]
        
        HTTPRequests.submitCompany(parameters: "", RequestMethod: "POST", Data: bodyDictionary, completionHandler: {
            message in
            if (message != nil) {
                self.responseLabel.text = "Company Created"
            } else {
                self.responseLabel.text = "Company could not be Created"
            }
            self.responseLabel.isHidden = false
        })
        
        
    }
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
