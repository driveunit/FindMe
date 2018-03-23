//
//  Registration.swift
//  Find_Me
//
//  Created by ramyahar on 3/22/18.
//  Copyright © 2018 ramyahar. All rights reserved.
//

import UIKit

class Registration: UIViewController {
    
    //Labels
    @IBOutlet weak var usernameUILabel: UILabel!
    @IBOutlet weak var passwordUILabel: UILabel!
    @IBOutlet weak var confirmPasswordUILabel: UILabel!
    
    //TextFields
    @IBOutlet weak var usernameUIText: UITextField!
    @IBOutlet weak var passwordUITextField: UITextField!
    @IBOutlet weak var confirmPasswordUIText: UITextField!
    
    //Sigup Button : Action
    @IBAction func Signup(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
