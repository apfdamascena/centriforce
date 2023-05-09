//
//  GameBackground.swift
//  centriforce
//
//  Created by alexdamascena on 18/04/23.
//

import SwiftUI
import SpriteKit

class GameBackground: SKSpriteNode, AnySceneNode {
    
    private var screenSize: CGSize = .zero
    
    init(withSize size: CGSize, planet: RouteScreen) {
        self.screenSize = size
        let backgroundName = planet == .earth ? "earth-background" : "mars"
        let backgroundTexture = SKTexture(imageNamed: backgroundName)
        super.init(texture: backgroundTexture, color: .white, size: size)
        setupNode()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPosition() {
        self.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        self.size = CGSize(width: screenSize.width, height: screenSize.height)
        self.zPosition = 1
    }
}
