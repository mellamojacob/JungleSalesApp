//
//  MCompanyViewController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 2/6/17.
//  Copyright © 2017 Jacob Virgin. All rights reserved.
//

import UIKit

class MCompanyViewController: UIViewController {
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var submitCompButton: UIButton!
    @IBOutlet weak var EditButton: UIButton!
    @IBOutlet weak var SubmitNotesButton: UIButton!
    @IBOutlet weak var Message: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    ///Runs when view is loaded
    ///If the screen is being presented after selecting the 'add company' button, all fields are blank and the submit button is displayed
    /// If the screen is being presented after selecting a company, the company information and the edit button are displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.EditButton.isHidden = true
        self.Message.isHidden = true
        
        if chosenCompDict["tier"] as? String == "Proposal" {
            nextButton.isEnabled = false
        }
        
        if chosenCompDict["tier"] as? String == "Voice2Voice" {
            chosenCompDict["tier"] = "New"
        }
      
        if selectedComp {
            self.companyField.text = "\(chosenCompDict["company_name"]!)"
            self.phoneField.text = "\(chosenCompDict["phone_number"]!)"
            self.submitCompButton.isHidden = true
            self.EditButton.isHidden = false
            
            
        }
    }

    
    ///Submits a new company to the database
    @IBAction func Submit(_ sender: Any) {
        //let username = Variables.username()
        
        if(companyField.hasText && phoneField.hasText){
            let companyJSON: [String: AnyObject] = ["company_name": companyField.text as AnyObject, "phone_number": phoneField.text as AnyObject, "tier": "Voice2Voice" as AnyObject, "time_stamp" : 8 as AnyObject]
            
            HTTPRequests.submitCompany(Data: companyJSON, completionHandler: { message in
                
                self.warningLabel.text = message
                
            })
        } else {
            self.warningLabel.text = "Please add an appropriate Company name and phone number."
        }
        
       
    }
    
    ///Edits a company currently existing in the database with the information written in
    @IBAction func edit(_ sender: Any) {
        let id: String = chosenCompDict["_id"] as! String
        
        print(chosenCompDict["company_name"] as! String)
        
        var compDict: [String: AnyObject] = [:]
        if companyField.text != chosenCompDict["company_name"] as? String {
            compDict["company_name"] = companyField.text as AnyObject
        }
        if phoneField.text != chosenCompDict["phone_number"] as? String {
            compDict["phone_number"] = phoneField.text as AnyObject
        }
        
        
        //let compDict = chosenCompDict as NSDictionary
        //guard let companyJSON = compDict as? [String : AnyObject] else {
        //  return
        //}
        
        print("id: \(id)")
        
//        if let int: Array.Index = voice2voiceCompanies.index(of: chosenCompDict) {
//            print(int)
//        }
        
        HTTPRequests.editCompany(parameters: id, Data: compDict, completionHandler: { message in
            self.warningLabel.text = message
            self.warningLabel.isHidden = false
            
            if self.companyField.hasText {
                chosenCompDict["company_name"] = self.companyField.text!
            }
            if self.phoneField.hasText {
                chosenCompDict["phone_number"] = self.phoneField.text!
            }
        })
        
    }

    @IBAction func Back(_ sender: Any) {
        print("back")
        
        let MainVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        UIApplication.shared.delegate?.window??.rootViewController = MainVC
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func Next(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        var tier = "Default"
        
        if ((chosenCompDict["tier"] as? String) != nil) {
            tier = chosenCompDict["tier"] as! String
        }
        
        switch tier{
        case "New":
            let alert = UIAlertController(title: "Contact the Customer", message: "How would you like to contact the customer?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.default, handler: {
                action in
                let callscriptsVC = storyboard.instantiateViewController(withIdentifier: "CallScriptViewController")
                alert.dismiss(animated: true, completion: nil)
                self.present(callscriptsVC, animated: true, completion: nil)
                return
            }))
            alert.addAction(UIAlertAction(title: "Email", style: .default, handler: {
                action in
                let emailtemplatesVC = storyboard.instantiateViewController(withIdentifier: "EmailTemplateVC")
                alert.dismiss(animated: true, completion: nil)
                self.present(emailtemplatesVC, animated: true, completion: nil)
                return
            }))
            self.present(alert, animated: true, completion: nil)
            break;
            
        case "Voice2Voice" :
            let alert = UIAlertController(title: "Contact the Customer", message: "How would you like to contact the customer?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Schedule a Visit", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Send Proposal", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Not Interested", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Call Back", style: .default, handler: nil))
            break;
            
        case "Face2Face" :
            let alert = UIAlertController(title: "Send Proposal", message: "Send the customer a proposal!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Send Proposal", style: .default, handler: {
                action in
                let proposalVC = storyboard.instantiateViewController(withIdentifier: "SendProposalVC") as! SendProposalViewController
                self.present(proposalVC, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Not Interested", style: .default, handler: nil))
            break;
            
        case "Proposal" :
            
            break;
            
        default:
            break;
        }

    }
    
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
