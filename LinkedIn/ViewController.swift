//
//  ViewController.swift
//  OAuthSwift
//
//  Created by Dongri Jin on 6/21/14.
//  Copyright (c) 2014 Dongri Jin. All rights reserved.
//

import UIKit
import OAuthSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func doOAuthLinkedin(){
        let oauthswift = OAuth2Swift(
            consumerKey:    Linkedin["consumerKey"]!,
            consumerSecret: Linkedin["consumerSecret"]!,
            authorizeUrl:   "https://www.linkedin.com/uas/oauth2/authorization",
            accessTokenUrl: "https://www.linkedin.com/uas/oauth2/accessToken",
            responseType:   "code"
        )
        let state: String = generateStateWithLength(20) as String
        oauthswift.authorizeWithCallbackURL( NSURL(string: "http://oauthswift.herokuapp.com/callback/linkedin2")!, scope: "r_basicprofile", state: state, success: {
            credential, response in
            self.showAlertView("LinkedIn", message: "oauth_token:\(credential.oauth_token)")
            var parameters =  Dictionary<String, AnyObject>()
            oauthswift.client.get("https://api.linkedin.com/v1/people/~?format=json", parameters: parameters,
                success: {
                    data, response in
                    let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println(dataString)
                }, failure: {(error:NSError!) -> Void in
                    println(error)
            })
            }, failure: {(error:NSError!) -> Void in
                println(error.localizedDescription)
        })
    }

    func showAlertView(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func loginLinkedIn(sender: UIButton) {
        doOAuthLinkedin()
    }
}

