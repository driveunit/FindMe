//
//  AccountDetails.swift
//  Find_Me
//
//  Created by ramyahar on 3/22/18.
//  Copyright © 2018 ramyahar. All rights reserved.
//

//
//  AccountDetails.swift
//  FindMe
//
//  Created by ramyahar on 3/21/18.
//  Copyright © 2018 ramyahar. All rights reserved.
//

import UIKit
import AWSAuthCore
import AWSAuthUI
import AWSCognitoIdentityProvider

var s3BucketName = "driveunit-find-me"
var myIdentityPoolId = "us-east-1:e81582cd-95ba-4122-a0cb-e0d8db820a6f"
let myPoolRegion = AWSRegionType.USEast1

class AccountDetails: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !AWSSignInManager.sharedInstance().isLoggedIn {
            AWSAuthUIViewController
                .presentViewController(with: self.navigationController!,
                                       configuration: nil,
                                       completionHandler: { (provider: AWSSignInProvider, error: Error?) in
                                        if error != nil {
                                            print("Error occurred: \(String(describing: error))")
                                        } else {
                                            // Sign in successful.
                                        }
                })
        }
        // Do any additional setup after loading the view.
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
