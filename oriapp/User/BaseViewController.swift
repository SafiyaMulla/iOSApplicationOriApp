//
//  BaseViewController.swift
//  oriapp
//
//  Created by Admin on 22/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import Alamofire

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func makeApiCall(path: String,  completionHandler: @escaping (Any?) -> Void, method: HTTPMethod = .get, parameters: Parameters? = nil) {
       // let url = "http://192.168.0.108:4000" + path
        let url = "http://172.18.4.110:4000" + path
        print("calling API: \(url)")
        AF.request(url, method: method, parameters: parameters,encoding:JSONEncoding())
            .responseJSON(completionHandler: { response in
                let result = response.value as! [String: Any]
                let status = result["status"] as! String
                if status == "success" {
                    completionHandler(result["data"])
                } else {
                    print("Error while calling API: \(result["error"]!)")
                }
            })
    }
}

