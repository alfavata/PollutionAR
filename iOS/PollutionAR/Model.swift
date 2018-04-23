//
//  Model.swift
//  PollutionAR
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 theguardian. All rights reserved.
//

import Foundation

/*

 {
 "results": [{
 "layerId": 0,
 "layerName": "NC_All",
 "displayFieldName": "",
 "attributes": {
 "Class value": "143",
 "Pixel Value": "5"
 }
 }]
 }

 */

struct Model: Codable {
    struct Result: Codable {
        struct Attributes: Codable {
            enum CodingKeys: String, CodingKey {
                case value = "Pixel Value"
            }
            let value: String
        }
        let attributes: Attributes
    }
    let results: [Result]
}
