//
//  IntermediaryVC.swift
//  WhatToEat
//
//  Created by Kevin Lee on 9/6/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

class IntermediaryVC: UIViewController {
    
    var userSelection: UserSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(userSelection)
        
//        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(transitionss))
//        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.left
//        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func transitionss() {
//        performSegue(withIdentifier: "ToCategorySelect", sender: self)
//    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
