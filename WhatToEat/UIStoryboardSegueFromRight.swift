//
//  UIStoryboardSegueFromRight.swift
//  WhatToEat
//
//  Created by Kevin Lee on 9/6/17.
//  Copyright © 2017 Kevin Lee. All rights reserved.
//

import UIKit

class UIStoryboardSegueFromRight: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform.init(translationX: src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        dst.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
                        },
                       completion: { finished in
                        src.present(dst, animated: false, completion: nil)
                        }
        )
    }
}

class UIStoryboardUnwindSegueFromRight: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.source as UIViewController
        let dst = self.destination as UIViewController
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.view.transform = CGAffineTransform.init(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                         src.view.transform = CGAffineTransform.init(translationX: src.view.frame.size.width, y: 0)
                        },
                       completion: { finished in
                         src.dismiss(animated: false, completion: nil)
                        }
        )
    }
}
