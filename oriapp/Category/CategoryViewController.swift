//
//  CategoryViewController.swift
//  oriapp
//
//  Created by Admin on 22/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import  Alamofire
class CategoryViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onLipcare() {
    }
    @IBAction func onHairCare(_ sender: Any) {
    }
    @IBAction func onSkin() {
    }
    
    @IBAction func onMakeup() {
        let transactionsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MakeupkitViewController")
                                  self.navigationController?.pushViewController(transactionsVC, animated: true)
    }
    
}
