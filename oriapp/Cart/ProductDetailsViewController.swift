//
//  ProductDetailsViewController.swift
//  oriapp
//
//  Created by Admin on 27/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
class ProductDetailsViewController: BaseViewController {

    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    var product: Products?
    var products : [Products] = []
    var product_id = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(product)")
        product_id = product!.product_id
        print(product_id)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        loadProductDetail()
    }
    func loadProductDetail()
    {
        products.removeAll()
         makeApiCall(path: "/product/details/"+String(product_id),
                           completionHandler: {result in
                        let tempProduct = result as! [[String: Any]]
                            for object in tempProduct  {
                            
                                let product_id = object["product_id"] as! Int
                                    let  product_name = object["product_name"] as! String
                                   let product_description = object["product_description"] as! String
                                let product_price = object["product_price"] as! Float
                                   let thumbnail = object["thumbnail"] as! String
                                  
                                let tproduct = Products(product_id:product_id, product_name:product_name,product_description:product_description,product_price:product_price,thumbnail : thumbnail)
                                   
                                self.products.append(tproduct)
                                  // print("\(self.transactions)")
                                print("\(self.products)")
                                self.productName.text = self.products[0].product_name
                                self.productDescription.text = self.products[0].product_description
                                self.productPrice.text = String(self.products[0].product_price)
                                 self.product_id = self.products[0].product_id
                                let url1 = URL(string: "http://172.18.4.110:4000/\(self.products[0].thumbnail)")
                                                               
                                self.productImage.kf.setImage(with:url1)
                                let user_id =  UserDefaults.standard.value(forKey: "user_id") as! Int
                                print("\(type(of: user_id)) \(user_id)")
                               }
        })
        
    }
    
    @IBAction func addCart() {
        let body = [
                  "user_id": UserDefaults.standard.value(forKey: "user_id")
              ]
              
              makeApiCall(path: "/cart/add/"+String(product_id),
              completionHandler: { result in
              
                   let alert = UIAlertController(title: "Success", message: "cart added successfully.", preferredStyle: .alert)
                                                             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                                 //self.navigationController?.popViewController(animated: true)
                                                                self.dismiss(animated: true, completion: nil)
                                                             }))
                                                             self.present(alert, animated: true, completion: nil)
                      
              }, method: .post, parameters: body)
    }
    
    @IBAction func onCancel(_ sender: Any) {
           dismiss(animated: true, completion: nil)
    }
}
