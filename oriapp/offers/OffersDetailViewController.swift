//
//  OffersDetailViewController.swift
//  oriapp
//
//  Created by Admin on 29/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

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
class OffersDetailViewController: BaseViewController {

    @IBOutlet weak var editname: UILabel!
    
    @IBOutlet weak var editfinal: UILabel!
    @IBOutlet weak var editDiscount: UILabel!
    @IBOutlet weak var editPrice: UILabel!
    @IBOutlet weak var editdesc: UILabel!
    @IBOutlet weak var editImage: UIImageView!
    var offer: offers?
       var products : [offers] = []
       var offer_id = 0
       override func viewDidLoad() {
           super.viewDidLoad()
           
           offer_id = offer!.offer_id
           
          
       }
    
    
    
    @IBAction func onBuynow() {
        let alert = UIAlertController(title: "Success", message: " offers Order Save successfully.", preferredStyle: .alert)
                                                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                                       //self.navigationController?.popViewController(animated: true)
                                                      self.dismiss(animated: true, completion: nil)
                                                   }))
                                                   self.present(alert, animated: true, completion: nil)
    }
    
       override func viewDidAppear(_ animated: Bool) {
           loadProductDetail()
       }
    func loadProductDetail()
    {
        products.removeAll()
         makeApiCall(path: "/offer/details/"+String(offer_id),
                           completionHandler: {result in
                        let tempProduct = result as! [[String: Any]]
                            for object in tempProduct  {
                            
                                let offer_id = object["offer_id"] as! Int
                                    let  product_name = object["product_name"] as! String
                                   let product_description = object["product_description"] as! String
                                let product_price = object["product_price"] as! Float
                                let discount = object["discount"] as! Float
                                let final_price = object["final_price"] as! Float
                                let thumbnail = object["thumbnail"] as! String
                                  
                                let tproduct = offers(offer_id:offer_id, product_name:product_name,product_description:product_description,product_price:product_price,discount:discount,final_price:final_price,thumbnail : thumbnail)
                                   
                                self.products.append(tproduct)
                                  // print("\(self.transactions)")
                                print("\(self.products)")
                                self.editname.text = self.products[0].product_name
                                self.editdesc.text = self.products[0].product_description
                                self.editPrice.text = String(self.products[0].product_price)
                                self.editDiscount.text = String(self.products[0].discount)
                                self.editfinal.text = String(self.products[0].final_price)
                                 self.offer_id = self.products[0].offer_id
                                
                                let url1 = URL(string: "http://172.18.4.110:4000/\(self.products[0].thumbnail)")
                                                               
                                self.editImage.kf.setImage(with:url1)
                                let user_id =  UserDefaults.standard.value(forKey: "user_id") as! Int
                                print("\(type(of: user_id)) \(user_id)")
                               }
        })
        
    }
    
}

