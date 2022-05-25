//
//  RoundButton.swift
//  DemoCalculator
//
//  Created by Vu Thanh Nam on 24/05/2022.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable var roundButton:Bool = false {
        didSet{
            if roundButton{
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    override  func prepareForInterfaceBuilder() {
        if roundButton{
            layer.cornerRadius = frame.height / 2
        }
    }
}
