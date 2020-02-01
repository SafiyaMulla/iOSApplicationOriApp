//
//  RegistrationViewController.swift
//  oriapp
//
//  Created by Admin on 22/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
class RegistrationViewController: BaseViewController{

    @IBOutlet weak var onPhone: UITextField!
    @IBOutlet weak var onPassword: UITextField!
    @IBOutlet weak var onEmail: UITextField!
    @IBOutlet weak var onAddress: UITextField!
    @IBOutlet weak var onName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Register User"
              navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(onRegister))
        
    }
    

   
    @IBAction func onRegister() {
   if onName.text!.count == 0 {
              showError(message: "Name is mandatory")
          } else if onPassword.text!.count == 0 {
              showError(message: "Password is mandatory")
          } else if onPhone.text!.count == 0 {
              showError(message: "Phone is mandatory")
          } else if onEmail.text!.count == 0 {
              showError(message: "Email is mandatory")
          } else {
              
              let body = [
                  "customer_name": onName.text!,
                  "address":onAddress.text!,
                  "email_id": onEmail.text!,
                  "password": onPassword.text!,
                  "mobile_no": onPhone.text!
              ]
              
              makeApiCall(path: "/customer/cust_register",
                          completionHandler: { result in
                          
                              let alert = UIAlertController(title: "success", message: "Registered a new user. Please login now.", preferredStyle: .alert)
                              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                  self.navigationController?.popViewController(animated: true)
                              }))
                              self.present(alert, animated: true, completion: nil)
                                  
                          }, method: .post, parameters: body)
              
          }
      }
      
  }
