//
//  DataFetcher.swift
//  PollutionAR
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 theguardian. All rights reserved.
//

import Foundation
import CoreLocation

private extension Double {
    func metersToLatitude() -> Double {
        return self / (6360500.0)
    }

    func metersToLongitude() -> Double {
        return self / (5602900.0)
    }
}


final class DataFetcher {

    func fetchData(for location: CLLocation, completionHandler: @escaping (Int?)->Void) {

        let delta: Double = 1 // meters

        // https://webgis.erg.kcl.ac.uk/arcgis/rest/services/Test_Now/MapServer/identify?geometry=-0.0782078504562378,51.517521845711826&geometryType=esriGeometryPoint&layers=0&sr=4326&tolerance=1&mapExtent=-0.0704718504562378,51.517521845711826,-0.0685790904562378,51.52086084571182&imageDisplay=&returnGeometry=false&f=json

        let baseUrl = "https://webgis.erg.kcl.ac.uk/arcgis/rest/services/Test_Now/MapServer/identify"
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "geometry", value: "\(location.coordinate.longitude),\(location.coordinate.latitude)"),
            URLQueryItem(name: "geometryType", value: "esriGeometryPoint"),
            URLQueryItem(name: "layers", value: "0"),
            URLQueryItem(name: "sr", value: "4326"),
            URLQueryItem(name: "tolerance", value: "1"),
            URLQueryItem(name: "mapExtent", value:
                "\(location.coordinate.longitude - delta.metersToLongitude()),\(location.coordinate.latitude - delta.metersToLatitude()),"
                + "\(location.coordinate.longitude + delta.metersToLongitude()),\(location.coordinate.latitude + delta.metersToLatitude())"),
            URLQueryItem(name: "imageDisplay", value: "750,500,96"),
            URLQueryItem(name: "returnGeometry", value: "false"),
            URLQueryItem(name: "f", value: "json")
        ]
        guard let url = urlComponents?.url else {
            print("URL failed")
            completionHandler(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let model = try? JSONDecoder().decode(Model.self, from: data),
                let value = model.results.first?.attributes.value,
                let intValue = Int(value) {
                print("New value fetched: \(intValue)")
                completionHandler(intValue)
            } else {
                print("Failure")
                completionHandler(nil)
            }
        }.resume()
    }
}
