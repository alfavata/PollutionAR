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

extension ViewController: SceneLocationViewDelegate {
    func sceneLocationViewDidAddSceneLocationEstimate(sceneLocationView: SceneLocationView,
                                                      position: SCNVector3,
                                                      location: CLLocation) {
    }

    func sceneLocationViewDidRemoveSceneLocationEstimate(sceneLocationView: SceneLocationView,
                                                         position: SCNVector3,
                                                         location: CLLocation) {
    }

    func sceneLocationViewDidConfirmLocationOfNode(sceneLocationView: SceneLocationView,
                                                   node: LocationNode) {
    }

    func sceneLocationViewDidSetupSceneNode(sceneLocationView: SceneLocationView,
                                            sceneNode: SCNNode) {
    }

    func sceneLocationViewDidUpdateLocationAndScaleOfLocationNode(sceneLocationView: SceneLocationView,
                                                                  locationNode: LocationNode) {

    }
}

