//
//  ResultViewController.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/18/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit
import MapKit

class ResultViewController: UIViewController {
    
    var restaurant: Restaurant?
    var shownLocation = false
    
    @IBOutlet weak var mapView: MKMapView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        
        if let foundRestaurant = restaurant {
            print(foundRestaurant)
            
            mapView.delegate = self
            
            let restaurantAnnotation = RestaurantAnnotation(restaurant: foundRestaurant)
            mapView.addAnnotation(restaurantAnnotation)
            mapView.selectAnnotation(mapView.annotations[0], animated: true)
            mapView.showAnnotations(mapView.annotations, animated: false)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if(!shownLocation) {
            mapView.showAnnotations(mapView.annotations, animated: true)
            shownLocation = true
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
