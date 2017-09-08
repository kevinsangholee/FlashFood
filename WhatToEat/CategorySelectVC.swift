//
//  CategorySelectVC.swift
//  WhatToEat
//
//  Created by Kevin Lee on 9/5/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

class CategorySelectVC: UIViewController {

    var selectedCategories: [String]?
    var categoryButtons = [UIButton]()
    var allCategoryTitles = [String]()
    let defaults = UserDefaults.standard
    var userSelection = UserSelection(categories: nil, price: nil, distance: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryButtons = getButtons()
        selectedCategories = defaults.array(forKey: "categories") as? [String]
        
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
    
    @IBOutlet weak var categoryStatement: UILabel!
    @IBOutlet weak var categoryContinue: UIButton!
    @IBOutlet weak var categoryContinueCover: UIView!
    @IBOutlet weak var categoryStatementCover: UIView!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categoryScrollView.alpha = 0
        categoryStatement.alpha = 0
        categoryStatement.center.y = view.center.y
        categoryContinue.center.y = view.center.y
        let when = DispatchTime.now() + 2.3
            DispatchQueue.main.asyncAfter(deadline: when) {
            self.categoryStatement.text = "What kind of food?"
        }
        UIView.animate(withDuration: 0.7, delay: 0.1, options: [.curveEaseInOut], animations: {
            self.categoryStatement.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.2, delay: 2.6, options: [.curveEaseInOut], animations: {
            self.categoryStatement.center.y -= (self.view.bounds.height / 2) - 46.5
            self.categoryContinue.center.y += (self.view.bounds.height / 2) - 22
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.2, delay: 2.8, options: [.curveEaseInOut], animations: {
            self.categoryStatement.center.y += 35
            self.categoryContinue.center.y -= 35
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.2, delay: 3.0, options: [.curveEaseInOut], animations: {
            self.categoryStatement.center.y -= 15
            self.categoryContinue.center.y += 15
            self.view.layoutIfNeeded()
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 2.2, animations: {
            self.categoryScrollView.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 1.65, options: [.curveEaseIn], animations: {
            self.categoryStatementCover.alpha = 1
        }, completion: nil)
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
    
    @IBAction func MoveToPricing(_ sender: UIButton) {
        userSelection.categories = selectedCategories
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PriceIntermediary") as? IntermediaryVC {
            vc.userSelection = userSelection
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func getButtons() -> [UIButton] {
        var buttonArray = [UIButton]()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                for button in view.subviews[0].subviews {
                    buttonArray.append(button as! UIButton)
                    allCategoryTitles.append((button as! UIButton).currentTitle!)
                }
            }
        }
        
        return buttonArray
    }

}
