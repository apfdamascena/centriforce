//
//  EarthView.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import Foundation
import SwiftUI
import SpriteKit


struct EarthView: UIViewRepresentable {
    
    var didUserClickGoToMarrs: (() -> ())?
    
    func makeUIView(context: Context) -> SKView {
        
        let scene = GameScene(withSize: UIScreen.main.bounds.size,
                              planet: .earth)

        let skView = SKView(frame: UIScreen.main.bounds)
        scene.scaleMode = .aspectFill
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        skView.presentScene(scene)
        
        scene.actionForMarth = didUserClickGoToMarrs
        
        return skView
    }


    func updateUIView(_ uiView: SKView, context: Context) {
    }
}
