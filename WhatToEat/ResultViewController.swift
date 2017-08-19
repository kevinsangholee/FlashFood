//
//  ResultViewController.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/18/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIViewContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}

class ResultViewController: UIViewController {

    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var address1Label: UILabel!
    @IBOutlet weak var address2Label: UILabel!
    @IBOutlet weak var address3Label: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var restaurant: Restaurant?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let foundRestaurant = restaurant {
            nameLabel.text = foundRestaurant.name
            address1Label.text = foundRestaurant.address[0]
            address2Label.text = foundRestaurant.address[1]
            if (foundRestaurant.address.count == 3) {
                address3Label.text = foundRestaurant.address[2]
            } else {
                address3Label.isHidden = true
            }
            phoneNumberLabel.text = foundRestaurant.phone_number
            
            restaurantImageView.layer.borderWidth = 1.0
            restaurantImageView.layer.masksToBounds = false
            restaurantImageView.layer.cornerRadius = restaurantImageView.frame.height / 2
            restaurantImageView.contentMode = UIViewContentMode.scaleAspectFill
            
            let url = URL(string: foundRestaurant.image_url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    self.restaurantImageView.maskCircle(anyImage: UIImage(data: data!)!)
                }
            }
        }
        
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
