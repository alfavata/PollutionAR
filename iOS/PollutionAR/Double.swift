//
//  Double.swift
//  PollutionAR
//
//  Created by Andrew Reed on 20/07/2018.
//  Copyright © 2018 theguardian. All rights reserved.
//


private extension Double {

    private static let metersInLatitude = 6360500.0
    private static let metersInLongitude = 5602900.0

    func metersToLatitude() -> Double {
        return self / (Double.metersInLatitude)
    }
    
    func metersToLongitude() -> Double {
        return self / (Double.metersInLongitude)
    }

}
