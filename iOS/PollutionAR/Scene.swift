//
//  Scene.swift
//  PollutionAR
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 theguardian. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {

    //consider having a constants file and a strings file.
    static let smokeParticleName = "Smoke"
    static let cameraTranslation = Float(exactly: -0.2)!

    let smokePath = Bundle.main.path(forResource: Scene.smokeParticleName, ofType: "sks")

    override func didMove(to view: SKView) {
        backgroundColor = UIColor.black

        let particle = NSKeyedUnarchiver.unarchiveObject(withFile: smokePath!) as! SKEmitterNode
        particle.position = CGPoint(x: size.width/2, y: size.height)
        particle.name = Scene.smokeParticleName
        particle.targetNode = scene

        addChild(particle)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let sceneView = view as? ARSKView else {
            return
        }

        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = Scene.cameraTranslation
            let transform = simd_mul(currentFrame.camera.transform, translation)

            // Add a new anchor to the session
            sceneView.session.add(anchor: ARAnchor(transform: transform))
        }
    }
}
