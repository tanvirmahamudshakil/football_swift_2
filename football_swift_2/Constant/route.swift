//
//  route.swift
//  football_1
//
//  Created by Tanvir on 21/2/24.
//

import Foundation
import SwiftUI



class Router: ObservableObject {
    static var shared = Router()
    @Published var path = NavigationPath()
}
