//
//  RestaurantAnnotation.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/27/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import MapKit
import Foundation

class RestaurantAnnotation: NSObject, MKAnnotation {
    let title: String?
    let mileage: String
    let coordinate: CLLocationCoordinate2D
    
    init(restaurant: Restaurant) {
        title = restaurant.name
        mileage = restaurant.phone_number
        coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
        
        
        super.init()
    }
    
    var subtitle: String? {
        return mileage
    }
}

extension ResultViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? RestaurantAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.init(type: UIButtonType.detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
}
