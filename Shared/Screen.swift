//
//  Screen.swift
//  Render
//
//  Created by Aadish Verma on 4/15/22.
//
//  Screen, the basis for the Interface rendering engine, Render, and the renderer of the shape library: CanvasAPI
import Foundation
import SwiftUI
import Darwin
public let framed = true
public struct Coordinate: Hashable {
    var x, y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    func tuple() -> (Int, Int) {
        return (x, y)
    }
}
public typealias Coord = Coordinate
public typealias Vector = Coordinate
public struct Screen {
    var pixels: [Coordinate: Color?] = [:]
    var dimensions: Coordinate
    init(dimensions: (Int, Int)) {
        self.dimensions = Coordinate(dimensions.0, dimensions.1)
        for x in 0..<dimensions.0 {
            for y in 0..<dimensions.1 {
                pixels[Coordinate(x, y)] = Color?(nil)
            }
        }
        if framed == true { for x in 0..<self.dimensions.x {
            for y in 0..<self.dimensions.y {
                if (y == 0 || x == 0 || y == dimensions.1 - 1 || x == dimensions.0 - 1) {pixels[Coordinate(x, y)] = Color.black}
            }
        } }
    }
    init(dimensions: Coordinate) {
        self.dimensions = dimensions
        for x in 0..<dimensions.x {
            for y in 0..<dimensions.y {
                pixels[Coordinate(x, y)] = Color?(nil)
            }
        }
        if framed == true { for x in 0..<self.dimensions.x {
            for y in 0..<self.dimensions.y {
                if (y == 0 || x == 0 || y == dimensions.y - 1 || x == dimensions.x - 1) {pixels[Coordinate(x, y)] = Color.black}
            }
        } }
    }

    subscript(x: Int, y: Int) -> Color? {
        get {
            return pixels[Coordinate(x, y)]!
        }
        set {
            pixels[Coordinate(x, y)] = newValue
        }
    }
    mutating func ViewBuilder(@Renderer _ views: () -> [ViewData]) {
        for view in views() {
            view.0(&self, view.1)
        }
    }
}

