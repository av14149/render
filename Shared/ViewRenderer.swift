//
//  ViewRenderer.swift
//  Render
//
//  Created by Aadish Verma on 5/8/22.
/// The ViewRenderer is the biggest upgrade of Render 2.0. It offers a far better alternative to the Canvas API of Canvas 1.0. In v1, shapes and other additions had to be hard-coded as functions in extensions to `Screen`, reducing the flexibility of the API. Render 2.0 offers a protocol (`Renderable`), which structures can be aligned to, that provides a starting point for shapes, text, and the like. By taking advantage of the revolution in protocol-oriented programming, Render 2.0 introduces a flexible framework for rendering elements. HOORAY!!!!!!!
import Foundation
import SwiftUI

public typealias Render<Unit> = (inout Screen, Unit.Encoded) -> Void where Unit: Renderable
public typealias CompileRender = (inout Screen, Any) -> Void
public typealias ModifierValue = Any
public typealias ViewData = (CompileRender, Any)

struct Call<ValueType> {
    var call: ValueType
    init(_ raw: Any?) {call = raw! as! ValueType}
}
// Yeah... Render is the easy-to-use ter so we'releaving that to the developers and we use the CompileRender term because Any is too dark for the consumer.
// This is a sad moment. The second part of ViewData was supposed to be the Encoded struct of a Renderable. But generic protocol thingies aren't allowed forced for this workaround :( In the Screen interpretation it would be called as "[name of ViewData var].1 as! [Renderable-conforming struct].Encoded"...
public protocol Renderable {
    static var modifiers: [Self.Modifier: Provider] {get}
    static var render: (inout Screen, Encoded) -> Void {get}
    static var supportedDefaults: [Defaults] {get}
    static func encoder(_ data: [Self.Modifier: Any]) -> Encoded
    associatedtype Encoded
    associatedtype Modifier: Hashable
}
public protocol MainRenderable: Renderable {}
public struct EmptyStruct: Hashable, Equatable {
    
}
extension MainRenderable {
    public typealias Encoded = EmptyStruct
    public static func encoder(_ data: [Modifier : Any]) -> Encoded {
        EmptyStruct()
    }
    public typealias Modifier = EmptyStruct
    

}
public enum Provider {
    case provided
    case defaultTo(Any)
}
public enum Defaults {
    case fill, border
    var label: String { "\(self)"}
}
extension Renderable {
    
    static func view(_ parameters: [Self.Modifier: Any]) -> ViewData {
        var final: [Self.Modifier: Any] = [:]
        for modifier in self.modifiers {
            let provider = modifier.value
            var value: Any? = nil
            if parameters.keys.contains(modifier.key) {value = parameters[modifier.key]!}
            switch provider {
                case .provided:
                    if value == nil {
                        fatalError("Renderer for Renderable \(Self.self): ERROR on func 'view'. Required parameter '\(modifier.key)' not provided.")
                    }
                case .defaultTo(let defaultValue):
                    if value == nil {value = defaultValue}
            }
            final[modifier.key] = value
        }
        /// TODO: Add support for the `Defaults` package
        let generatedRender: CompileRender = {s, a in
            Self.render(&s, a as! Self.Encoded)
        }
        return (generatedRender, encoder(final) as Any)
    }
//    static func render(to screen: inout Screen, _ data: Self.Encoded) {
//        self.render(to: &screen, modifiers)
//    }
}
/// TODO: Redo `withCondition`. Actually, no. Delete it. To easy for developers. Use `for` with `where` to get the same effect.
//func withCondition(_ condition: @escaping (Int, Int, [String: Modifier]) -> Color?) -> (_ canvas: inout Screen, _ modifierGroup: [String: Modifier]) -> Void {
//    func view(canvas: inout Screen, _ modifierGroup: [String: Modifier]) -> Void {
//        for key in canvas.pixels.keys {
//            guard let replacement: Color? = condition(key.x, key.y, modifierGroup)! else {break}
//            canvas.pixels[key] = replacement!
//        }
//    }
//    return view
//}

@resultBuilder struct Renderer {
    static func buildBlock() -> [ViewData] { [] }
    static func buildBlock(_ renders: ViewData...) -> [ViewData] { renders }
    static func buildBlock(_ renders: [ViewData]) -> [ViewData] { renders }
}


/// ViewRender SERVICES — These helpful functions are like the supporting cells of the brain, helping maintain a smooth landscape where performance is optimal, code is simple, and there are no rendering blowups :)


public func range<Bound>(_ one: Bound, _ two: Bound) -> ClosedRange<Bound> where Bound: Comparable {
    if one<two {
        return one...two
    }
    else {
        return two...one
    }
}
