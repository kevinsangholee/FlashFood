//
//  ViewController.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/5/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, CategoryProtocol {


    @IBOutlet weak var priceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceSegmentedControl: UISegmentedControl!
    
    var selectedCategories: [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "What Do I Eat?"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Goes to the categories view controller, passing through the selected categories if it has already been done.
    @IBAction func ViewCategoriesButton(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Categories") as? CategoryViewController {
            vc.delegate = self
            if let categoriesAlreadySelected = selectedCategories {
                vc.selectedCategories = categoriesAlreadySelected
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let valueFromView = selectedCategories {
            print(valueFromView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func decideWhereToEat(_ sender: UIButton) {
        let price = Price(rawValue: priceSegmentedControl.selectedSegmentIndex)
        let distance = Distance(rawValue: distanceSegmentedControl.selectedSegmentIndex)
        if let categories = selectedCategories {
            YelpApi.callYelpApi(price: price!, distance: distance!, categories: categories) { response, error in
                if let json = response {
                    let restaurants = YelpApi.parseRestaurants(jsonData: json)
                    let shuffledRestaurants = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: restaurants) as! [Restaurant]
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "Result") as? ResultViewController {
                        vc.restaurant = shuffledRestaurants[0]
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Search not complete!", message: "Select your categories before searching.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Got it", style: .default))
            present(ac, animated: true)
        }
    }

    // Delegate method
    func setCategoriesDesired(categories: [String]) {
        self.selectedCategories = categories
    }

    
}

