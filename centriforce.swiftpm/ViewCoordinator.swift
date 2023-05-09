//
//  ViewCoordinator.swift
//  centriforce
//
//  Created by alexdamascena on 19/04/23.
//

import Foundation

enum RouteScreen {
    case earth
    case mars
}


import SwiftUI

class ViewCordinator: ObservableObject {
    
    @Published var path: [RouteScreen] = []
    
    func push(view newView: RouteScreen){
        path.append(newView)
    }
    
    func pop(){
        path.removeLast()
    }
}
