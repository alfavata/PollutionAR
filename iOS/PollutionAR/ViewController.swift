//
//  ViewController.swift
//  PollutionAR
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 theguardian. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreLocation
import ARCL

class ViewController: UIViewController {

    let sceneLocationView = SceneLocationView()
    let fetcher = DataFetcher()
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneLocationView.locationDelegate = self
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }
}

extension ViewController: ARSKViewDelegate {
    
}

extension ViewController: SceneLocationViewDelegate {
    func sceneLocationViewDidAddSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {
//        fetcher.fetchData(for: location) {
//            guard let value = $0 else { return }
//            for _ in 0 ..< value {
//                let randomDeltaLat = (Double(arc4random_uniform(UInt32.max)/UInt32.max) * 10.0 - 5.0).metersToLatitude()
//                let randomDeltaLng = (Double(arc4random_uniform(UInt32.max)/UInt32.max) * 10.0 - 5.0).metersToLongitude()
//                let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude + randomDeltaLat,
//                                                        longitude: location.coordinate.longitude + randomDeltaLng)
//                let location = CLLocation(coordinate: coordinate, altitude: location.altitude - 1.5)
//                let   node = ParticleNode(location: location, value: value)
//                sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: node)
//            }
//        }
    }

    func sceneLocationViewDidRemoveSceneLocationEstimate(sceneLocationView: SceneLocationView, position: SCNVector3, location: CLLocation) {

    }

    func sceneLocationViewDidConfirmLocationOfNode(sceneLocationView: SceneLocationView, node: LocationNode) {

    }

    func sceneLocationViewDidSetupSceneNode(sceneLocationView: SceneLocationView, sceneNode: SCNNode) {

    }

    func sceneLocationViewDidUpdateLocationAndScaleOfLocationNode(sceneLocationView: SceneLocationView, locationNode: LocationNode) {

    }
}

private extension Double {
    func metersToLatitude() -> Double {
        return self / (6360500.0)
    }

    func metersToLongitude() -> Double {
        return self / (5602900.0)
    }
}
