//
//  File.swift
//  
//
//  Created by alexdamascena on 18/04/23.
//

import Foundation


protocol AnySceneNode {
    
    func setupPosition()
    func setupPhysicsBody()
    func setupAdditionalConfiguration()
    func addChilds()
}

extension AnySceneNode {
    
    func setupNode(){
        setupPosition()
        setupPhysicsBody()
        addChilds()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration(){}
    func setupPhysicsBody(){}
    func addChilds(){}
}
