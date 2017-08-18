//
//  MainViewController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 2/3/17.
//  Copyright © 2017 Jacob Virgin. All rights reserved.
//

import UIKit

var voice2voiceCompanies: [NSDictionary] = []
var face2faceCompanies: [NSDictionary] = []
var proposalCompanies: [NSDictionary] = []
var contractCompanies: [NSDictionary] = []

var chosenCompDict : NSMutableDictionary = [:]

var selectedComp: Bool = false

var index: NSIndexPath = NSIndexPath()

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var contractTable: UITableView!
    @IBOutlet weak var proposalTable: UITableView!
    @IBOutlet weak var f2fTable: UITableView!
    @IBOutlet weak var v2vTable: UITableView!
    
    @IBOutlet weak var workerName: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    
    
        
    var selectedCompany: NSDictionary = [:]
    var selectedCompanies: [NSDictionary] = []
    
    ///Opens MCompanyViewController
    @IBAction func AddComp(_ sender: Any) {
        selectedComp = false
    }
    
    @IBAction func Reload(_ sender: Any) {
        HTTPRequests.getRequest(databaseToRequest: .companies, withSpecifications: "Voice2Voice", completionHandler: {
            companies in
            
            voice2voiceCompanies = companies
            
            print(voice2voiceCompanies)
            
            DispatchQueue.main.async {
                self.v2vTable.reloadData()
                print("data reloaded")
            }
            
        })

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            self.v2vTable.reloadData()
//        }
//    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.workerName.text = username
            self.points.text = "\(salePoints)"
            self.rank.text = "\(saleRank)"
        
        print("view did load")
            
            //GETS all of the companies that we want to display for each table
            HTTPRequests.getRequest(databaseToRequest: .companies, withSpecifications: "Voice2Voice", completionHandler: {
                companies in
                
                voice2voiceCompanies = companies
                
                
                DispatchQueue.main.async {
                    self.v2vTable.reloadData()
                }

            })
            
            HTTPRequests.getRequest(databaseToRequest: .companies, withSpecifications: "Face2Face", completionHandler: {
                companies in
                
                face2faceCompanies = companies
                
                DispatchQueue.main.async {
                    self.f2fTable.reloadData()

                }

            })
            
            HTTPRequests.getRequest(databaseToRequest: .companies, withSpecifications: "Proposal", completionHandler: {
                companies in
                
                proposalCompanies = companies
                self.contractTable.reloadData()

            })
            
            HTTPRequests.getRequest(databaseToRequest: .companies, withSpecifications: "Contract", completionHandler: {
                companies in
                
                contractCompanies = companies
                self.proposalTable.reloadData()

            })
            
            
            
            //Sets up each table's environment
            self.v2vTable.dataSource = self
            self.v2vTable.delegate = self
            self.v2vTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            self.f2fTable.dataSource = self
            self.f2fTable.delegate = self
            self.f2fTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            self.proposalTable.dataSource = self
            self.proposalTable.delegate = self
            self.proposalTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
            self.contractTable.dataSource = self
            self.contractTable.delegate = self
            self.contractTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        
        
        
        
        
        
        
        
        
    //Decides how many cells are displayed in a tableview
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            var count: Int = 0
            
            if tableView == self.v2vTable{
                count = voice2voiceCompanies.count
            } else if tableView == self.f2fTable{
                count = face2faceCompanies.count
            } else if tableView == self.proposalTable {
                count = proposalCompanies.count
            } else if tableView == self.contractTable {
                count = contractCompanies.count
            }
            
            
            return count
            
        }
    
    //Decides what is displayed in a cell
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            //index = indexPath
            
            if tableView == self.v2vTable {
                let cell : UITableViewCell = self.v2vTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.textColor = UIColor.black
                let compDict: NSDictionary = voice2voiceCompanies[indexPath.row]
                if let label: String = compDict.value(forKey: "company_name") as? String {
                    cell.textLabel?.text = label
                }
            } else if tableView == self.f2fTable {
                let cell : UITableViewCell = self.f2fTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.textColor = UIColor.black
                let compDict: NSDictionary = face2faceCompanies[indexPath.row]
                if let label: String = compDict.value(forKey: "company_name") as? String {
                    cell.textLabel?.text = label
                }
            }else if tableView == self.proposalTable {
                let cell : UITableViewCell = self.proposalTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.textColor = UIColor.black
                let compDict: NSDictionary = proposalCompanies[indexPath.row]
                if let label: String = compDict.value(forKey: "company_name") as? String {
                    cell.textLabel?.text = label
                }
            }else if tableView == self.contractTable {
                let cell : UITableViewCell = self.contractTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.textLabel?.textColor = UIColor.black
                let compDict = contractCompanies[indexPath.row]
                if let label: String = compDict.value(forKey: "company_name") as? String {
                    cell.textLabel?.text = label
                }
            }
            return UITableViewCell()
        }
    
    // Decides what happens when a cell is selected
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            selectedComp = true

            
            if tableView == self.v2vTable {
                chosenCompDict = NSMutableDictionary(dictionary: voice2voiceCompanies[indexPath.row])
            } else if tableView == self.f2fTable {
                chosenCompDict = NSMutableDictionary(dictionary: face2faceCompanies[indexPath.row])
            }else if tableView == self.f2fTable {
                chosenCompDict = NSMutableDictionary(dictionary: proposalCompanies[indexPath.row])
            }else if tableView == self.f2fTable {
                chosenCompDict = NSMutableDictionary(dictionary: contractCompanies[indexPath.row])
            }
            
            

            let MCompanyVC = storyboard.instantiateViewController(withIdentifier: "MCompanyViewController") as UIViewController
            
            //This completion handler might come in handy, look it up
            
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = MCompanyVC
            
            //self.present(MCompanyVC, animated: true, completion: nil)
            
        }
        
}
