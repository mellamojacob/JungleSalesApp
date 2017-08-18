
//
//  OptionsViewController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 6/21/17.
//  Copyright © 2017 Jacob Virgin. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    let schedule: Bool = false

    @IBOutlet weak var leftVMButon: UIButton!
    @IBOutlet weak var followUpButton: UIButton!
    @IBOutlet weak var scheduleVisitButton: UIButton!
    @IBOutlet weak var noVoicemailButton: UIButton!
    @IBOutlet weak var notInterestedButton: UIButton!
    @IBOutlet weak var sendProposalButton: UIButton!
    
    //  var companyDict
    var tier = Tier.convertToTier(chosenCompDict["tier"] as! String)
    
    override func viewDidLoad() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MCompanyViewController")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func leftVM(_ sender: Any) {
        chosenCompDict["notes"] = "Current Date: \(username) left Voicemail"
        tier = Tier.moveUpTier(tier)
        chosenCompDict["tier"] = "\(tier)"
        print(chosenCompDict["notes"] as! String)
        let MCompany = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MCompanyViewController") as! MCompanyViewController
        self.present(MCompany, animated: true)
    }
  
    @IBAction func followUp(_ sender: Any) {
        let datePickerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DatePickerVC")
        // self.addChildViewController(datePickerVC)
        self.present(datePickerVC, animated: true, completion: nil)
        
        
    }
    
    @IBAction func scheduleVisit(_ sender: Any) {
        
        
        let datePickerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DatePickerVC") as! DatePickerViewController
        // self.addChildViewController(datePickerVC)
        
        datePickerVC.setVisit = true
        
        self.present(datePickerVC, animated: true, completion: nil)
            
        
        
    }
    
    @IBAction func noVM(_ sender: Any) {
        //Send email
        //Set follow up on Node.js
    }
    
    @IBAction func notInterested(_ sender: Any) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func sendProposal(_ sender: Any) {
        let EmailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailTemplateVC") as! EmailTemplateViewController
        
        self.present(EmailVC, animated: true, completion: {
            EmailVC.sendProposal.sendActions(for: .touchUpInside)
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

}
