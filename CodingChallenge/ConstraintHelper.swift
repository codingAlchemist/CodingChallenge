//
//  ConstraintHelper.swift
//  AnimalIdAppiOS
//
//  Created by jason debottis on 3/26/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit

class ConstraintHelper{
    
    static func visualFormatHelper(parent: UIView, format:String, children: NSDictionary) -> [NSLayoutConstraint] {
        for case let child as UIView in children.allValues{
            child.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: children as! [String : AnyObject])
        parent.addConstraints(constraint)
        return constraint
    }
}