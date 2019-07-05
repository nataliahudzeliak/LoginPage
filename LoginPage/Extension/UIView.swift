//
//  UIView.swift
//  LoginPage
//
//  Created by Family on 7/4/19.
//  Copyright © 2019 Family. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: [ViewSide], withColor color: CGColor, andThickness thickness: CGFloat) {
        for side in side {
            let border = CALayer()
            border.backgroundColor = color
            switch side {
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
                border.name = "left"
            case .right:
                border.frame = CGRect(x: frame.maxX - thickness, y: 0, width: thickness, height: frame.height)
                border.name = "right"
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
                border.name = "top"
            case .bottom:
                border.frame = CGRect(x: 0, y: bounds.maxY - thickness, width: frame.size.width, height: thickness)
                border.name = "bottom"
            }
            layer.addSublayer(border)
        }
    }
}

