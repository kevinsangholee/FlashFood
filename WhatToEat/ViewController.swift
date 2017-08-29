//
//  ViewController.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/5/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit
import MapKit
import GameKit

class ViewController: UIViewController, CategoryProtocol {

    var locManager = CLLocationManager()
    var currentDistance = 1

    @IBOutlet weak var priceSegmentedControl: UISegmentedControl!
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func decideWhereToEat(_ sender: UIButton) {
        // User configurations
        let price = Price(rawValue: priceSegmentedControl.selectedSegmentIndex)
        let coordinates = getCurrentCoordinates()
        
        // Checking for location grabbed
        if let currentLocation = coordinates {
            if let categories = selectedCategories {
                YelpApi.callYelpApi(price: price!, distance: currentDistance, categories: categories, location: currentLocation) { response, error in
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
                showIncompleteSearchAlert()
            }
        } else {
            showNoLocationAlert()
        }
    }

    @IBAction func updateDistance(_ sender: UISlider) {
        let distanceValue = Int(floor(sender.value))
        if(currentDistance != distanceValue) {
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
        currentDistance = distanceValue
        distanceLabel.text = distanceValue == 1 ? "\(distanceValue) mile" : "\(distanceValue) miles"
    }
    
    func showIncompleteSearchAlert() {
        let ac = UIAlertController(title: "Search not complete!", message: "Select your categories before searching.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Got it", style: .default))
        present(ac, animated: true)
    }
    
    func showNoLocationAlert() {
        let ac = UIAlertController(title: "Location Not Found", message: "Please allow the app to access location services to continue.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Got it", style: .default))
        present(ac, animated: true)
    }
    
    func getCurrentCoordinates() -> Coordinates? {
        // Location Grabber
        var currentLocation: CLLocation!
        locManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
            currentLocation = locManager.location
            let currentLat = currentLocation.coordinate.latitude
            let currentLong = currentLocation.coordinate.longitude
            return Coordinates(latitude: Float(currentLat), longitude: Float(currentLong))
        } else {
            return nil
        }
    }
    
    // Delegate method
    func setCategoriesDesired(categories: [String]) {
        self.selectedCategories = categories
    }

    
}

