//
//  Car.swift
//  centriforce
//
//  Created by alexdamascena on 18/04/23.
//

import SwiftUI
import SpriteKit

class Car: SKNode, AnySceneNode {
    
    var image : SKSpriteNode?
    let size: CGSize
    var endOnboarding = false
    
    var planet: RouteScreen
    
    init(withSceneSize: CGSize, planet: RouteScreen) {
        self.image = SKSpriteNode(imageNamed: "car")
        self.size = withSceneSize
        self.planet = planet
        super.init()
        setupNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChilds() {
        guard let image = image else { return }
        addChild(image)
    }
    
    func setupPosition() {
        let midleOfScreen = size.width * 0.13
        let yPosition = size.height * 0.32
        self.position = CGPoint(x: midleOfScreen, y: yPosition)
    }
    
    func setupPhysicsBody() {
        guard let image = self.image else { return }
        let imageSize = image.size

        let texture = SKTexture(imageNamed: "car")

        self.physicsBody = SKPhysicsBody(texture: texture,
                                         size: imageSize)
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.restitution = 0.0
    }
    
    
    func setupAdditionalConfiguration() {
        self.zPosition = 2
    }
    
    func update(with velocity: Int){
        var currentVelocity: Int = velocity
        
        if velocity < 9 && planet == .earth {
            currentVelocity = 9
        }
        
        if velocity > 20 && planet == .earth {
            currentVelocity = 20
        }
        
        if (velocity == 16 || velocity == 17) && planet == .earth {
            currentVelocity = 18
        }
        
        var shouldFly = false
        
        if currentVelocity > 15 && planet == .earth {
            shouldFly = true
        }
        
        if currentVelocity > 10 && planet == .mars {
            shouldFly = true
        }
        
        let newPosition = self.position.x + CGFloat(currentVelocity)
        self.position.x = newPosition
        
        if position.x >= size.width / 2 && shouldFly {
            self.position.y += 15
        }
    }
    
    func update(onOnboarding velocity: Int) -> Bool {
        let newPosition = self.position.x + CGFloat(velocity)
        
        if newPosition > size.width / 2 + 20 {
            if endOnboarding {
                self.position.x = newPosition
                return false
            }
            return true
        }
        
        self.position.x = newPosition
        
        return false
    }
    
    func userEndOnboarding(){
        endOnboarding = true
    }
    
    func refreshIfNeeded() -> Bool {
        if self.position.x >= size.width {
            self.physicsBody?.isDynamic = false
            self.position.x = 100
            self.position.y = size.height * 0.32
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                self.physicsBody?.isDynamic = true
            }
            return true
        }
        
        return false
    }
}
