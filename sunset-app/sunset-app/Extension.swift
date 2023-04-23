//
//  Extension.swift
//  sunset-app
//
//  Created by Adrian Ma on 4/23/23.
//

import Foundation
import UIKit

extension UIColor {
    static func interpolate(from startColor: UIColor, to endColor: UIColor, with percentage: CGFloat) -> UIColor {
            var fromRed: CGFloat = 0, fromGreen: CGFloat = 0, fromBlue: CGFloat = 0, fromAlpha: CGFloat = 0
            var toRed: CGFloat = 0, toGreen: CGFloat = 0, toBlue: CGFloat = 0, toAlpha: CGFloat = 0
            
            startColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
            endColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)
            
            let red = fromRed + (toRed - fromRed) * percentage
            let green = fromGreen + (toGreen - fromGreen) * percentage
            let blue = fromBlue + (toBlue - fromBlue) * percentage
            let alpha = fromAlpha + (toAlpha - fromAlpha) * percentage
            
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
}

