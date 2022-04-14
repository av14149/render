//
//  RenderApp.swift
//  Shared
//
//  Created by Aadish Verma on 4/14/22.
//

import SwiftUI

@main
struct RenderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(dimensions: Coordinate(1000, 1000))
        }
    }
}

