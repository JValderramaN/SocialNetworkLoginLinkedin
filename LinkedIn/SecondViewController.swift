//
//  SecondViewController.swift
//  LinkedIn
//
//  Created by Office-UpperSky-Hackintosh on 31/05/15.
//  Copyright (c) 2015 Dongri Jin. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift

class SecondViewController: UIViewController {
    @IBOutlet weak var textField: UILabel!
    
    var firstName = NSString()
    var lastName = NSString()

    override func viewDidLoad() {
        super.viewDidLoad()
        var parameters =  Dictionary<String, AnyObject>()
        oauthswift.client.get("https://api.linkedin.com/v1/people/~?format=json", parameters: parameters,
            success: {
                data, response in
                let jsonDict: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
                println(jsonDict)
                
                self.firstName = jsonDict.valueForKey("firstName") as NSString!
                self.lastName = jsonDict.valueForKey("lastName") as NSString!
                self.textField.text = "Hi, I'm \(self.firstName) \(self.lastName)"
                
                println(self.firstName)
                
            }, failure: {(error:NSError!) -> Void in
                println(error)
        })
    }
    
    
}