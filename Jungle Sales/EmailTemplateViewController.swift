//
//  EmailTemplateViewController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 7/3/17.
//  Copyright © 2017 Jacob Virgin. All rights reserved.
//

import UIKit

class EmailTemplateViewController: UIViewController {

    @IBOutlet weak var sendProposal: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func presentTemplate(_ sender: Any) {
        
        let sendEmailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SendEmailVC")
        
        self.present(sendEmailVC, animated: true, completion: nil)
        
//        UIApplication.shared.keyWindow?.rootViewController?.present(sendEmailVC, animated: true, completion: nil)
    }
    
    @IBAction func sendProposal(_ sender: Any) {
        let proposalVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SendProposalVC") as! SendProposalViewController
        self.present(proposalVC, animated: true, completion: nil)
        
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
