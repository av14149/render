//
//  Canvas.swift
//  Render
//
//  Created by Aadish Verma on 4/15/22.
//
// Extension to Screen that I call Canvas -- modern API for the Screen rendering engine
import Foundation
import SwiftUI
import Darwin
//struct Line: ViewRenderable {
//    static var defaults: [String: Default] = [
//        "point.one": .provided,
//        "point.two": .provided,
//        "color": .defaultTo(Color.black)
//    ]
//    internal enum LineType {
//        case normal(Float), vertical, horizontal
//    }
//    static var getView: ViewRender = { canvas, modifiers in
//        var type: LineType {
//            var point = (modifiers.call<Coordinate>("point.one"), modifiers.call<Coordinate>("point.two"))
//
//        }
//    }
//}
struct Circle: Renderable {
    
    static func encoder(_ data: [Modifier : Any]) -> Encoded {
        let center = Call<Coordinate>(data[.center]).call
        let xc = center.x; let yc = center.y
        let radsqrt = Call<Int>(data[.radius]).call
        let fillColor = Call<Color>(data[.fill]).call
        return Encoded(xc: xc, yc: yc, radius: radsqrt*radsqrt, fill: fillColor)
    }
    
    
    struct Encoded {
        let xc, yc, radius: Int
        let fill: Color
        func checkPixel(_ pixel: Coordinate) -> Bool {
            return (pixel.y-yc)*(pixel.y-yc)+(pixel.x-xc)*(pixel.x-xc) <= radius
        }
    }
    
    enum Modifier {
        case fill, center, radius
    }
    
    static var supportedDefaults: [Defaults] = []
    
    static var modifiers: [Modifier: Provider] = [
        .fill: .defaultTo(Color.blue),
        .center: .provided,
        .radius: .provided
    ]
    static var render: Render<Self> = { canvas, encoded in
        for pixel in canvas.pixels.keys where encoded.checkPixel(pixel) {
            canvas.pixels[pixel] = encoded.fill
        }
    }
}
//struct Rectangle: Renderable {
//    static var defaults: [String:Default] = [
//        "fill": .defaultTo(Color.green),
//        "point.one": .provided,
//        "point.two": .provided
//    ]
//    static var getView: Render = { canvas, modifiers in
//        let pointone = modifiers.call(Call<Coordinate>("point.one"))
//        let pointwo = modifiers.call(Call<Coordinate>("point.two"))
//        let xr = pointone.x..<pointwo.x
//        let yr = pointone.y..<pointwo.y
//        let fillColor = modifiers.call(Call<Color>("fill"))
//        for pixel in canvas.pixels.keys where xr.contains(pixel.x) && yr.contains(pixel.y) {
//            canvas.pixels[pixel] = fillColor
//        }
//    }
//}
