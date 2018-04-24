//
//  Scene.swift
//  PollutionEmoji
//
//  Created by Antonio Favata on 23/04/2018.
//  Copyright © 2018 GNM. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {

    func addAnchor() {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 1 meter in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -1
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            let anchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: anchor)
        }
    }
}
