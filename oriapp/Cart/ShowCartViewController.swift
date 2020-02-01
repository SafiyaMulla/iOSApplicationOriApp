//
//  ShowCartViewController.swift
//  oriapp
//
//  Created by Admin on 27/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
class ShowCartViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var transactions: [Carts] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self as! UITableViewDataSource
        tableView.delegate = self as! UITableViewDelegate
        // Do any additional setup after loading the view.
    }
   
    
    
   
    @IBAction func onPlaceOrder()
    {
         let alert = UIAlertController(title: "Success", message: "Orders Save successfully.", preferredStyle: .alert)
                                             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                 //self.navigationController?.popViewController(animated: true)
                                                self.dismiss(animated: true, completion: nil)
                                             }))
                                             self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadTransactions()
    }
    
   func loadTransactions() {
              transactions.removeAll()
      
                     let user_id = UserDefaults.standard.value(forKey: "user_id") as! Int
                       makeApiCall(path: "/cart/add_cart/"+String(user_id),
                                   completionHandler: {result in

                      let tempTransactions = result as! [[String: Any]]
                      for object in tempTransactions {
                        
                          let cart_id = object["cart_id"] as! Int
                          let product_id = object["product_id"] as! Int
                          let product_name = object["product_name"] as! String
                          let product_price = object["product_price"] as! Float
                          let thumbnail = object["thumbnail"] as! String
                        let carts = Carts(cart_id:cart_id,product_id:product_id,product_name: product_name,product_price: product_price,thumbnail:thumbnail)
                          self.transactions.append(carts)
                          
                      }
               self.tableView.reloadData()
              })
      }
    
  }

extension ShowCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "showcartcell")!
        
        let labelProductName = cell.viewWithTag(2) as! UILabel
        let labelProductPrice = cell.viewWithTag(3) as! UILabel
        let thumbnail = cell.viewWithTag(1) as! UIImageView
       
        let transaction = transactions[indexPath.row]
        labelProductName.text = transaction.product_name
       
        labelProductPrice.text = String(transaction.product_price)
        
         //let url1 = URL(string:"http://192.168.0.108:4000/\(transaction.thumbnail)")
        let url1 = URL(string:"http://172.18.4.110:4000/\(transaction.thumbnail)")
        print(transaction.product_id)
        print(transaction.product_name)
       // print("http://192.168.0.108:4000/\(transaction.thumbnail)")
        thumbnail.kf.setImage(with: url1)
        
        return cell
    }
}
    extension ShowCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let actionDelete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.transactions.remove(at: indexPath.row)
            tableView.reloadData()
        }

       return [actionDelete]
//
//}
//
//}

}
}
