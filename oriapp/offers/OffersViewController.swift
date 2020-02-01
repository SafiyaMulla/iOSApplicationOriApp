//
//  OffersViewController.swift
//  oriapp
//
//  Created by Admin on 29/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class OffersViewController: BaseViewController{
 var transactions: [offers] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
         super.viewDidLoad()
               tableView.dataSource = self as! UITableViewDataSource
                      tableView.delegate = self as! UITableViewDelegate

    }

      override func viewDidAppear(_ animated: Bool) {
               loadTransactions()
           }
    func loadTransactions() {
                       transactions.removeAll()
                
                       makeApiCall(path: "/offer/",
                                   completionHandler: {result in

                               let tempTransactions = result as! [[String: Any]]
                               for object in tempTransactions {
                               let offer_id = object["offer_id"] as! Int
           //                        let category_id = object["category_id"] as! Int
                                   let product_name = object["product_name"] as! String
                                   let product_description = object["product_description"] as! String
                                   let product_price = object["product_price"] as! Float
                                let discount = object["discount"] as! Float
                                let final_price = object["final_price"] as! Float
                                   let thumbnail = object["thumbnail"] as! String
                                let products = offers(offer_id:offer_id,product_name: product_name, product_description:product_description, product_price: product_price,discount:discount,final_price:final_price,thumbnail:thumbnail)
                                   self.transactions.append(products)
                               }
                        self.tableView.reloadData()
                       })


               }
               }

  

extension OffersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

      let cell = tableView.dequeueReusableCell(withIdentifier: "offerscell")!
              
             
              var thumbnail = cell.viewWithTag(1) as! UIImageView
              //var cartButton = cell.viewWithTag(5) as! UIButton
              let transaction = transactions[indexPath.row]
             
              
               //let url1 = URL(string:"http://192.168.0.108:4000/\(transaction.thumbnail)")
              let url1 = URL(string:"http://172.18.4.110:4000/\(transaction.thumbnail)")
              
              print("http://172.18.4.110:4000/\(transaction.thumbnail)")
              thumbnail.kf.setImage(with: url1)
              
              return cell
          }
}
extension OffersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OffersDetailViewController") as! OffersDetailViewController
        vc.offer = transactions[indexPath.row]
        
       
             present(vc, animated: true, completion: nil)
    }
}





