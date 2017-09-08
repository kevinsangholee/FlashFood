//
//  FirstSlideVC.swift
//  WhatToEat
//
//  Created by Kevin Lee on 9/5/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

class FirstSlideVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        perform(#selector(transitionss), with: nil, afterDelay: 2.0)
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(transitionss))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @IBOutlet weak var narrowDown: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //narrowDown.center.x = view.center.x // Place it in the center x of the view.
        //narrowDown.center.x -= view.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
        narrowDown.center.y = view.center.y
        // animate it from the left to the right
        UIView.animate(withDuration: 0.75, delay: 0.5, options: [.curveEaseOut], animations: {
            self.narrowDown.center.y -= self.view.bounds.height / 2 - 66.5
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func transitionss() {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategorySelect") as? CategorySelectVC {
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
