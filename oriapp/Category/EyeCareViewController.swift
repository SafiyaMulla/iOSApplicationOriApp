//
//  EyeCareViewController.swift
//  oriapp
//
//  Created by Admin on 29/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
class EyeCareViewController: BaseViewController {
var transactions: [Products] = []
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
             
                    makeApiCall(path: "/product/cat_product/" + String(10),
                                completionHandler: {result in

                            let tempTransactions = result as! [[String: Any]]
                            for object in tempTransactions {
                            let product_id = object["product_id"] as! Int
        //                        let category_id = object["category_id"] as! Int
                                let product_name = object["product_name"] as! String
                                let product_description = object["product_description"] as! String
                                let product_price = object["product_price"] as! Float
                                let thumbnail = object["thumbnail"] as! String
                                let products = Products(product_id:product_id,product_name: product_name, product_description:product_description, product_price: product_price,thumbnail:thumbnail)
                                self.transactions.append(products)
                            }
                     self.tableView.reloadData()
                    })


            }
            }

    extension EyeCareViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return transactions.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

          let cell = tableView.dequeueReusableCell(withIdentifier: "eyecell")!
                  
                  let labelProductName = cell.viewWithTag(1) as! UILabel
                  //let labelProductDescription = cell.viewWithTag(2) as! UILabel
                  let labelProductPrice = cell.viewWithTag(3) as! UILabel
                  var thumbnail = cell.viewWithTag(4) as! UIImageView
                  //var cartButton = cell.viewWithTag(5) as! UIButton
                  let transaction = transactions[indexPath.row]
                  labelProductName.text = transaction.product_name
                 // labelProductDescription.text = transaction.product_description
                  labelProductPrice.text = String(transaction.product_price)
                  
                   //let url1 = URL(string:"http://192.168.0.108:4000/\(transaction.thumbnail)")
                  let url1 = URL(string:"http://172.18.4.110:4000/\(transaction.thumbnail)")
                  print(transaction.product_id)
                  print(transaction.product_name)
                  print("http://172.18.4.110:4000/\(transaction.thumbnail)")
                  thumbnail.kf.setImage(with: url1)
                  
                  return cell
              }
    }
    extension EyeCareViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
            vc.product = transactions[indexPath.row]
            
           print("\(vc.product)")
                 present(vc, animated: true, completion: nil)
        }
    }




