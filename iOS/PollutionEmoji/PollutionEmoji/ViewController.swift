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
    var values = [(CLLocation, Int)]()
    var nodeLocations = [CLLocation]()
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        locator.delegate = self
        locator.requestWhenInUseAuthorization()
        locator.desiredAccuracy = 0.1
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

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            (self?.sceneView.scene as? Scene)?.addAnchor()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()

        timer?.invalidate()
        timer = nil
    }

    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {

        guard let location = locator.location else { return nil }
        guard !nodeLocations.contains(where: { $0.distance(from: location) < 1.0 }) else { return nil }
        guard let (_, value) = values.min(by: { $0.0.distance(from: location) < $1.0.distance(from: location) }) else { return nil }

        nodeLocations.append(location)

        let labelNode = SKLabelNode(text: value.emoji)
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        return labelNode
    }
}

extension ViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        guard !values.contains(where: { $0.0.distance(from: location) < 5 }) else { return }

        fetcher.fetchData(for: location) { [weak self] in
            if let value = $0 {
                print("Appending \(value)")
                self?.values.append((location, value))
            }
        }
    }
}
