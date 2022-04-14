//
//  ContentView.swift
//  Shared
//
//  Created by Aadish Verma on 4/14/22.
//
import SwiftUI
import CoreGraphics
extension GraphicsContext {
    mutating func screenAPI<Unit>(_ safety: Unit.Type, _ data: ViewData, dimensions: Coord) where Unit: Renderable {
        var canvas = Screen(dimensions: dimensions)
        data.0(&canvas, data.1)
        for (key, value) in canvas.pixels {
            self.fill(
                Path(CGRect(x: Double(key.x), y: Double(dimensions.y-key.y), width: 1, height: 1)),
                with: .color(value==nil ? .white : value!)
            )
        }
    }
}


struct ContentView: View {
    var dimensions: Coordinate
    var body: some View {
        Canvas { context, size in
            context.screenAPI(MainApp.self, MainApp.view([:]), dimensions: dimensions)
        }.frame(width: CGFloat(dimensions.x), height: CGFloat(dimensions.y))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(dimensions: Coordinate(1000, 1000))
    }
}
