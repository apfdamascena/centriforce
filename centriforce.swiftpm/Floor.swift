//
//  Floor.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import SwiftUI
import SpriteKit

class Floor: SKNode, AnySceneNode {

    var image : SKSpriteNode?
    let size: CGSize
    
    init(withSceneSize: CGSize) {
        self.image = SKSpriteNode(imageNamed: "floor")
     
        self.size = withSceneSize
        
        self.image?.size = CGSize(width: withSceneSize.width, height: image?.size.height ?? 0)
        self.image?.isHidden = true
        super.init()
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
        self.position = CGPoint(x: size.width/2 , y: size.height * 0.22)
        self.zPosition = 5
    }
    
    func setupPhysicsBody() {
        guard let image = self.image else { return }
        let imageSize = image.size
        
        let texture = SKTexture(imageNamed: "floor")
        
        self.physicsBody = SKPhysicsBody(texture: texture,
                                         size: imageSize)
        self.physicsBody?.isDynamic = false
    }
}
