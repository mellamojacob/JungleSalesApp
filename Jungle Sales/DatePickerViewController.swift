//
//  DatePickerViewController.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 7/3/17.
//  Copyright © 2017 Jacob Virgin. All rights reserved.
//

import UIKit

var date : Date = Date.init()

class DatePickerViewController: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var durationField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var setVisit: Bool = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(setVisit)
        
        //submitButton.title = "Use Default"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Submit(_ sender: Any) {
        if nameField.hasText {
            
        }
        
        
        date = datePicker.date
        
        print("Submitted")
        
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    //  @IBAction func Submit(_ sender: Any){
        
        
        
//        let MCompany = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MCompanyViewController") as! MCompanyViewController
//        self.present(MCompany, animated: true)
    
    // }
    
    

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
