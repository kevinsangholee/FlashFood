//
//  ZomatoAPIData.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/10/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Distance: Int {
    case close, medium, far
}

enum Price: Int {
    case oneDolla, twoDolla, threeDolla, fourDolla
}

struct Restaurant {
    
    var name: String
    var address: [String]
    var rating: Double
    var review_count: Int
    var latitude: Double
    var longitude: Double
    var price: Int
    var phone_number: String
    var image_url: String

}

struct YelpApi {
    
    static let access_key = "Bearer sRYZ4x-ye8lzI6xgkD8AwHRiRt-o_Jvv5hbSMdccmZh9qZiTksCm6TzkzR4ztBIUBEc9f1vEzY5O0dw-tWkEH6tYn353THhZ3IwsSFNAvOB4Ns20Bs3fq5J9CCeRWXYx"
    
    static let categoryToQuery = [
        "American": "tradamerican",
        "Asian": "asianfusion",
        "Breakfast and Brunch": "breakfast_brunch",
        "Buffet": "buffets",
        "Burgers": "burgers",
        "Chinese": "chinese",
        "Fast Food": "hotdogs",
        "Greek": "greek",
        "Gluten-Free": "gluten_free",
        "Indian": "indpak",
        "Italian": "italian",
        "Japanese": "japanese",
        "Korean": "korean",
        "Latin American": "latin",
        "Mediterranean": "mediterranean",
        "Mexican": "mexican",
        "Pizza": "pizza",
        "Sandwiches": "sandwiches",
        "Seafood": "seafood",
        "Thai": "thai",
        "Vegetarian": "vegetarian",
        "Vietnamese": "vietnamese"
    ]
    
    static let distanceCalculator: Dictionary<Distance, Int> = [
        Distance.close: 8046,
        Distance.medium: 16093,
        Distance.far: 24140
    ]
    
    static func callYelpApi(price: Price, distance: Distance, categories: [String], completionHandler: @escaping (JSON?, Error?) -> ()) {
        
        let parameters: Parameters = [
            "term": "restaurants",
            "price": String(price.rawValue + 1),
            "radius": distanceCalculator[distance]!,
            "latitude": 33.697145,
            "longitude":  -117.771581,
            "limit": 25,
            "categories": categories.map(convertCategoryToApi).joined(separator: ","),
            "open_now": true
        ]
    
        let headers: HTTPHeaders = [
            "Authorization": access_key
        ]
        
        Alamofire.request("https://api.yelp.com/v3/businesses/search", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completionHandler(json, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    static func parseRestaurants(jsonData: JSON) -> [Restaurant] {
        var restaurants = [Restaurant]()
        
        let businesses = jsonData["businesses"].arrayValue
        for business in businesses {
            let name = business["name"].stringValue
            let address = business["location"]["display_address"].arrayValue.map({$0.stringValue})
            let rating = business["rating"].doubleValue
            let review_count = business["review_count"].intValue
            let latitude = business["coordinates"]["latitude"].doubleValue
            let longitude = business["coordinates"]["longitude"].doubleValue
            let price = business["price"].stringValue.characters.count
            let phone = business["phone"].stringValue
            let image_url = business["image_url"].stringValue
            
            let restaurant = Restaurant(name: name, address: address, rating: rating, review_count: review_count, latitude: latitude, longitude: longitude, price: price, phone_number: phone, image_url: image_url)
            
            restaurants.append(restaurant)
        }
        
        return restaurants
    }
    
    static func convertCategoryToApi(category: String) -> String {
        return categoryToQuery[category]!
    }
}
