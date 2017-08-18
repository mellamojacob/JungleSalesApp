//
//  HTTPRequests.swift
//  Jungle Sales
//
//  Created by Jacob Virgin on 7/28/16.
//  Copyright © 2016 Jacob Virgin. All rights reserved.
//

import Foundation

enum Database: String {
    case companies
    case users
}


//TODO: Edit the editRequest function

class HTTPRequests {
    
    
    class func getRequest(databaseToRequest database: Database, withSpecifications specifications: String?, completionHandler: @escaping (_ companies: [NSDictionary]) ->()){
        
        var param = ""
        
        if specifications != nil {
            param = (specifications?.replacingOccurrences(of: " ", with: "%20"))!
        }
        
        let scriptUrl = "http://localhost:3000/api/\(database.rawValue)/"
        
        let urlWithParams = scriptUrl + param
        
        let finalUrl = URL(string: urlWithParams)
        
        let request = NSMutableURLRequest(url: finalUrl!)
        
        request.httpMethod = "GET"
       
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary{
                    
                    if let responseArray = convertedJsonIntoDict.value(forKey: "companies") as? [NSDictionary] {
                        completionHandler(responseArray)
                    }
                }
            } catch let error as NSError {
                print("Error \(error.localizedDescription)")
            }
        }) 
        task.resume()
    

    }
    
    
    //Submit an HTTP request
    class func submitCompany(Data bodyData: [String: AnyObject], completionHandler: @escaping (_ message: String) ->()){
        
        var responseString: String = ""
        
        let scriptUrl = "http://localhost:3000/api/companies"
        
        let finalUrl = URL(string: scriptUrl)
        
        let request = NSMutableURLRequest(url: finalUrl!)
        
        request.httpMethod = "POST"
        
        do{
            if JSONSerialization.isValidJSONObject(bodyData) {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyData, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            
        } catch let error as NSError{
            print("request could not be parsed \(error)")
        }
        
        let submitTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            if error != nil {
                return
            } else {
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary{
                        
                        print("Converted JSON after submission is \(convertedJsonIntoDict)")
                        
                        
                        
                        if convertedJsonIntoDict["message"] as? String != nil {
                            responseString = convertedJsonIntoDict["message"] as! String
                        } else if convertedJsonIntoDict["err"] as? String != nil{
                            responseString = convertedJsonIntoDict["err"] as! String
                        } else {
                            responseString = "Error parsing data"
                        }
                        completionHandler(responseString)
                    }
                } catch let error as NSError {
                    print("Error \(error.localizedDescription)")
                }
            }
        })
        
        submitTask.resume()
        
    }
    
    class func editCompany(parameters params: String, Data bodyData: [String: AnyObject], completionHandler: @escaping (_ message: String) ->()){
        
        print("bodyData : \(bodyData)")
        
        var responseString: String = ""
        
        var scriptUrl = "http://localhost:3000/api/companies"
        if params != "" {
            scriptUrl += "/\(params)"
        }
        
        let finalUrl = URL(string: scriptUrl)
        
        let request = NSMutableURLRequest(url: finalUrl!)
        
        request.httpMethod = "PUT"
        
        do{
            if JSONSerialization.isValidJSONObject(bodyData) {
                request.httpBody = try JSONSerialization.data(withJSONObject: bodyData, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            
        } catch let error as NSError{
            print("request could not be parsed \(error)")
        }
        
        let editTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            if error != nil {
                return
            } else {
                do {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary{
                        
                        print("converted JSON after edit is : \(convertedJsonIntoDict)")
                        
                        if convertedJsonIntoDict["message"] as? String != nil {
                            responseString = convertedJsonIntoDict["message"] as! String
                        } else if convertedJsonIntoDict["err"] as? String != nil{
                            responseString = convertedJsonIntoDict["err"] as! String
                        } else {
                            responseString = "Error parsing data"
                        }
                        completionHandler(responseString)
 
                    }
                } catch let error as NSError {
                    print("Error with Response \(error.localizedDescription)")
                }
            }
        })
        
        editTask.resume()
        
    }

    
}
