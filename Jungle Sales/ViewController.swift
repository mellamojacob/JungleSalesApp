//
//  ViewController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 7/21/16.
//  Copyright © 2016 Jacob Virgin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //INITIALIZERS
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
  
    
    var selectedCompany: NSDictionary = [:]
    var selectedCompanies: [NSDictionary] = []
    var voice2voiceCompanies: [NSDictionary] = []
    var face2faceCompanies: [NSDictionary] = []
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            HTTPRequests.getRequest(databaseToRequest: .companies, withSpecifications: "Voice2Voice", completionHandler: {
                companies in
                self.voice2voiceCompanies = companies
                
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    }
 
            })
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    
    
    
    
    
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return self.voice2voiceCompanies.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = UIColor.black
        if self.voice2voiceCompanies[(indexPath as NSIndexPath).row]["company_name"] != nil {
            print("\(self.voice2voiceCompanies[(indexPath as NSIndexPath).row]["company_name"]!)")
            cell.textLabel?.text = "\(self.voice2voiceCompanies[(indexPath as NSIndexPath).row]["company_name"]!)"
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let companyDict = voice2voiceCompanies[indexPath.row]
        print(companyDict)
        
        let CompanyDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "CompanyDetail") as! CompanyDetailVC
        
        
        CompanyDetailVC.companyNameField.text = companyDict.object(forKey: "company_name") as? String
        CompanyDetailVC.salespersonField.text = companyDict.object(forKey: "salesperson") as? String
        CompanyDetailVC.phoneNumberField.text = companyDict.object(forKey: "phone_number") as? String
        CompanyDetailVC.tierField.text = companyDict.object(forKey: "tier") as? String
        
        self.navigationController?.pushViewController(CompanyDetailVC, animated: true)
        
    }
    
}
