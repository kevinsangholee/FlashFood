//
//  CategoryViewController.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/9/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var fastFoodButton: UIButton!
    @IBOutlet weak var asianButton: UIButton!
    @IBOutlet weak var buffetButton: UIButton!
    @IBOutlet weak var mexicanButton: UIButton!
    
    var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Your Categories"
        // Do any additional setup after loading the view.
    }

    @IBAction func categoryPress(_ sender: UIButton) {
        print("Button pressed!")
        sender.isSelected = !sender.isSelected
        sender.alpha = sender.isSelected ? 1.0 : 0.3
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
