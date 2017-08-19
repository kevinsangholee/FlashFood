//
//  CategoryViewController.swift
//  WhatToEat
//
//  Created by Kevin Lee on 8/9/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

protocol CategoryProtocol {
    func setCategoriesDesired(categories: [String])
}

class CategoryViewController: UIViewController {
    @IBOutlet weak var americanButton: UIButton!
    @IBOutlet weak var asianButton: UIButton!
    @IBOutlet weak var buffetButton: UIButton!
    @IBOutlet weak var chineseButton: UIButton!
    @IBOutlet weak var fastFoodButton: UIButton!
    @IBOutlet weak var japaneseButton: UIButton!
    @IBOutlet weak var mediterraneanButton: UIButton!
    @IBOutlet weak var mexicanButton: UIButton!
    @IBOutlet weak var pizzaButton: UIButton!
    @IBOutlet weak var vegetarianButton: UIButton!
    
    var selectedCategories: [String]?
    var categoryButtons = [UIButton]()
    var allCategoryTitles = [String]()
    var delegate: CategoryProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Your Categories"
        
        categoryButtons = getButtonsRecursively(forView: view)
        
        if let categories = selectedCategories {
            let chosenSet: Set<String> = Set(categories)
            var allSet: Set<String> = Set(allCategoryTitles)
            allSet.subtract(chosenSet)
            for category in allSet {
                let index = allCategoryTitles.index(of: category)
                categoryButtons[index!].isSelected = false
                categoryButtons[index!].alpha = 0.3
            }
        } else {
            selectedCategories = allCategoryTitles
        }
        
    }
    
    func getButtonsRecursively(forView view: UIView) -> [UIButton] {
        var buttonArray = [UIButton]()
        
        for subview in view.subviews {
            buttonArray += getButtonsRecursively(forView: subview)
            
            if subview is UIButton {
                buttonArray.append(subview as! UIButton)
                allCategoryTitles.append((subview as! UIButton).currentTitle!)
            }
        }
        
        return buttonArray
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.setCategoriesDesired(categories: selectedCategories!)
    }

    @IBAction func categoryPress(_ sender: UIButton) {
        // If there is only one category left, alert the user that at least one must be selected
        if(sender.isSelected && selectedCategories!.count == 1) {
            let ac = UIAlertController(title: "Invalid Action!", message: "Please select at least one category to search.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Got it", style: .default))
            present(ac, animated: true)
            return
        }
        // Add or remove the category from the selected categories
        sender.isSelected = !sender.isSelected
        sender.alpha = sender.isSelected ? 1.0 : 0.3
        if sender.isSelected {
            selectedCategories!.append(sender.currentTitle!)
        } else {
            if let index = selectedCategories!.index(of: sender.currentTitle!) {
                selectedCategories!.remove(at: index)
            }
        }
        print(selectedCategories!)
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
