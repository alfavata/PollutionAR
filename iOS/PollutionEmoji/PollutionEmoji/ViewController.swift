//
//  ViewController.swift
//  PollutionEmoji
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 GNM. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit
import CoreLocation

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!

    let locator = CLLocationManager()
    let fetcher = DataFetcher()

    var valueToConsume: Int?
    var previousLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        locator.delegate = self
        locator.requestWhenInUseAuthorization()
        locator.desiredAccuracy = 1
        locator.startUpdatingLocation()

        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }

        for i in 1...10 {
            let edge: CGFloat = 30.0
            let label = UILabel(frame: CGRect(x: edge/2 + CGFloat(i) * edge, y: sceneView.frame.height - edge * 3/2, width: edge, height: edge))
            label.text = i.emoji
            sceneView.addSubview(label)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.

        guard let value = valueToConsume else { return nil }
        valueToConsume = nil

        let labelNode = SKLabelNode(text: value.emoji)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode
    }
}

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
//        if let distance = previousLocation?.distance(from: location), distance < 1 { return }

        fetcher.fetchData(for: location) { [weak self] in
            if let value = $0 {
                self?.valueToConsume = value
                self?.previousLocation = location
            }
        }
    }
}
