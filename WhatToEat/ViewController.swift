//
//  ViewController.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/5/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "What Do I Eat?"
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func ViewCategoriesButton(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Categories") as? CategoryViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

