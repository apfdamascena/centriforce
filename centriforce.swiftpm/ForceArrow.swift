//
//  ForceArrow.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import SwiftUI
import SpriteKit


enum ForceArrowType: String {
    case weight = "arrow-down-weight"
    case normal = "arrow-up-normal"
    case centripetal = "arrow-down-centripetal"
}

class ForceArrow: SKNode, AnySceneNode {
    
    var image : SKSpriteNode?
    let size: CGSize
    let type: ForceArrowType
    
    init(withSceneSize: CGSize, forceArrowType type: ForceArrowType) {
        self.image = SKSpriteNode(imageNamed: type.rawValue)
        self.type = type

        self.size = withSceneSize
        super.init()
        
        image?.name = type.rawValue
        self.name = type.rawValue
    
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
        self.zPosition = 6
        
        switch type {
        case .weight:
            self.position = CGPoint(x: size.width/2 + 30,
                                    y: size.height * 0.12)
        case .normal:
            self.position = CGPoint(x: size.width/2 ,
                                    y: size.height * 0.20)
        case .centripetal:
            self.position = CGPoint(x: size.width/2 - 60,
                                    y: size.height * 0.1)
        }

 
    }
}
