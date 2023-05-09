//
//  Arrow.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import SwiftUI
import SpriteKit


class NextArrow: SKNode, AnySceneNode {
    
    var image : SKSpriteNode?
    let size: CGSize
    
    init(withSceneSize: CGSize) {
        self.image = SKSpriteNode(imageNamed: "arrow-right")

        self.size = withSceneSize
        super.init()
        
        image?.name = "arrow-right"
        self.name = "arrow-right"
    
        setupNode()
    }
    
    func addChilds() {
        guard let image = image else { return }
        addChild(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPosition() {
        self.position = CGPoint(x: size.width/2 - 30,
                                y: size.height * 0.55)
        self.zPosition = 6
    }
}
