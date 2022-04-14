//
//  Text.swift
//  Render
//
//  Created by Aadish Verma on 4/15/22.
//
// Text, another API to extend Screen to provide text capabilities
/// Temporarily, Render will not be using its own `Text` class as to not hinder onging progress in many other areas. A call of `Text` in a ViewRender now defaults to a SwiftUI layover. Not much more is to be said. TODO: Add a quick doc entry on using the `Text` struct.
import Foundation
import SwiftUI
import Darwin
//V<2.1BD>
///New version
//typealias Font = [String: Letter]
//protocol Letter: ViewRenderable {
//    static var width: Double {get}
//}
//struct Text: ViewRenderable {
//    var defaults: [String : Modifier] = [
//        "strokeWidth": 2,
//        "height": 100,
//        "color": Color.black,
//        "text": nil,
//        "spacing": 0.1,
//        "at": Coordinate(10, 10)
//    ]
//    static var getView: ViewRender = {canvas, options in
//        var bottom_left = options.call(Call<Coordinate>("at"))
//        var curx = bottom_left.x
//        var y = bottom_left.y
//        for char in options.call(Call<String>("text")) {
//            canvas.view(to: &canvas, [])
//        }
//    }
//
//
//}

//import Foundation
//import SwiftUI
//import Darwin
//// For reference: OLD VERSION<0.01B>
//class Letter {
//    var widthFactor: Double
//    var getView: (Int, Int) -> Screen
//    init(length: Double, perform actions: @escaping (Int, Int) -> Screen ) {
//        widthFactor = length
//        getView = actions
//    }
//}
//extension Screen {
//    func Text(_ inp: String, of thick: Int = 1, at point: (Int, Int), height size: Int) {
//        var currentX=point.0
//        print()
//        for x in inp {
//            self.setView(
//                (
//                    (currentX, point.1),
//                    (Int(Double(point.0)+defaultFont[String(x)]!.widthFactor)*size, point.1+size-1)
//                ),
//                defaultFont[String(x)]!.getView(thick, size).pixels
//            )
//            currentX += Int(defaultFont[String(x)]!.widthFactor)*size
//        }
//    }
//}
//func o(_ wid: Int, size: Int) -> Screen {
//    var finfin = Screen.init((Int(size/2), size), frame: false, experimental: false)
//    finfin.circle(center: (size/4, size*3/4), radius: Int(size/4)-1)
//    return finfin
//}
//func O(_ wid: Int, size: Int) -> Screen {
//    var finfin = Screen.init((size, size), frame: false, experimental: false)
//    finfin.circle(center: (Int(size/2), Int(size/2)), radius: Int(size/2)-1)
//    return finfin
//}
//let defaultFont: [String: Letter] = [
//    "o":
//        Letter.init(length: 0.5, perform: o),
//    "O":
//        Letter.init(length: 1, perform: O)
//]
//// setView, an ability to replace an area of Screen.pixels with another array of equivalent size
//extension Screen {
//    func setView(_ points: ((Int, Int), (Int, Int)), _ replacing: Array<Array<Pixel>>) {
//        for x in 0..<points.1.0 {
//            for y in 0..<points.1.1 {
//                if replacing == defaultFont["o"]!.getView(1, 50).pixels {
//                    print(x, y)
//                }
//                self.pixels[y+points.0.1][x+points.0.0] = replacing[y][x]
//            }
//        }
//    }
//}
