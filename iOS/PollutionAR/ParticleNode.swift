//
//  ParticleNode.swift
//  PollutionAR
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 theguardian. All rights reserved.
//

import Foundation
import CoreLocation
import ARCL

private extension UIImage {

    class func withValue(_ value: Int) -> UIImage {
        let color: UIColor
        switch value {
        case 1:
            color = UIColor.blue.withAlphaComponent(0.5)
        case 2:
            color = .blue
        case 3:
            color = .green
        case 4:
            color = UIColor.yellow.withAlphaComponent(0.5)
        case 5:
            color = UIColor.orange.withAlphaComponent(0.5)
        case 6:
            color = .orange
        case 7:
            color = UIColor.red.withAlphaComponent(0.5)
        case 8:
            color = .red
        case 9:
            color = .brown
        default:
            color = .black
        }

        let rect = CGRect(x: 0, y: 0, width: 5.0, height: 5.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

class ParticleNode: LocationAnnotationNode {

    init(location: CLLocation?, value: Int) {
        super.init(location: location, image: .withValue(value))
        scaleRelativeToDistance = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
