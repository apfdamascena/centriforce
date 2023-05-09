//
//  CardInstructions.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import SwiftUI
import SpriteKit

class CardInstruction: SKNode, AnySceneNode {
    
    var image : SKSpriteNode?
    let size: CGSize
    var indexInstructions = 0
    
    init(withSceneSize: CGSize) {
        self.image = SKSpriteNode(imageNamed: "onboarding-\(indexInstructions)")
        self.size = withSceneSize
        super.init()
        self.name = "card-instructions"
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
        self.position = CGPoint(x: size.width/4,
                                y: size.height * 0.55)
        self.zPosition = 6
    }
    
    func userTapNextArrow() -> Int{
        indexInstructions += 1
        if indexInstructions >= 7 {
            indexInstructions = 6
        }
        let newTexture = SKTexture(imageNamed: "onboarding-\(indexInstructions)")
        image?.texture = newTexture
        return indexInstructions
    }
    
    func marsOnAppear(){
        let newTexture = SKTexture(imageNamed: "mars-on-appear")
        image?.texture = newTexture
    }
}
