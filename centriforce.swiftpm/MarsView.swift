//
//  Mars.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import SwiftUI
import SpriteKit

struct MarsView: UIViewRepresentable {
    
    
    var didUserClickGoToMarrs: (() -> ())?
    
    func makeUIView(context: Context) -> SKView {
        
        let scene = GameScene(withSize: UIScreen.main.bounds.size,
                              planet: .mars)

        let skView = SKView(frame: UIScreen.main.bounds)
        scene.scaleMode = .aspectFill
        scene.physicsWorld.gravity = CGVector(dx: 0, dy: -3.72)
        skView.presentScene(scene)
                
        return skView
    }


    func updateUIView(_ uiView: SKView, context: Context) {
    }
    
}
