//
//  DNRouter.swift
//  router
//
//  Created by dongnguyen on 14/6/24.
//

import Foundation
import SwiftUI

final class DNRouter: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case livingroom
        case bedroom(owner: String)
    }
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
}
