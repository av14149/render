//
//  main.swift
//  Render
//
//  Created by Aadish Verma on 8/10/22.
//

import Foundation
import SwiftUI
public struct MainApp: MainRenderable {
    public static var render: Render<Self> = {canvas, modifiers in
        canvas.ViewBuilder {
            Circle.view([.radius: 200, .center: Coord(500, 500), .fill: Color.blue])
        }
    }
    
    public static var supportedDefaults: [Defaults] = []
    public static var modifiers: [Modifier: Provider] = [:]
}
/// example for the ViewBuilder:
// Circle.render([...])
