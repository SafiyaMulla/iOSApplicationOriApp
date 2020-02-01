//
//  LoginViewController.swift
//  oriapp
//
//  Created by Admin on 22/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
class LoginViewController: BaseViewController {

    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var editEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onLogin()
    {
        
   if editEmail.text!.count == 0 {
               showError(message: "Email is mandatory")
           } else if editPassword.text!.count == 0 {
               showError(message: "Password is mandatory")
           } else {
               let body = [
                   "email_id": editEmail.text!,
                   "password": editPassword.text!
               ]
               
    //let url = "http://192.168.0.108:4000/customer/login"
               let url = "http://172.18.4.110:4000/customer/login"
    AF.request(url, method: .post, parameters: body,encoding:JSONEncoding())
                   .responseJSON(completionHandler: { response in
                       let result = response.value as! [String: Any]
                       let status = result["status"] as! String
                       if status == "success" {
                           
                           let data = result["data"] as! [String: Any]
                           let id = data["user_id"] as! Int
                           let name = data["customer_name"] as! String
                           
                           // persist the userId in user defaults
                           let userDefaults = UserDefaults.standard
                           userDefaults.setValue(id, forKey: "user_id")
                           userDefaults.setValue(name, forKey: "customer_name")
                           userDefaults.synchronize()
                           
                           let transactionsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CategoryViewController")
                           self.navigationController?.pushViewController(transactionsVC, animated: true)
                           
                       } else {
                           self.showError(message: "Invalid email or pasword")
                       }
                   })
           }
    }
   }

