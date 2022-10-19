//
//  Shape.swift
//  Projects
//
//  Created by BRR on 7.08.2022.
//

import SwiftUI

struct Shape: View {
    var startColor:Color
    var endColor:Color
    var angle:ShapeAngle
    var cornerRadius:Double
    var lineWidth:Double
    var lineColor:Color
    
    let uiscreen = UIScreen.main.bounds
    
    var body: some View {
        Rectangle()
            .fill(angleView())
            .cornerRadius(cornerRadius)
            //.border(lineColor, width: lineWidth)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineColor, lineWidth: lineWidth)
            )
//            .edgesIgnoringSafeArea(.all)
    }
    
    func angleView() -> LinearGradient {
        
        switch angle {
        case .horizontal:
            
            return LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                           startPoint: .leading,
                           endPoint: .trailing)
        case .vertical:
            
            return LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                           startPoint: .top,
                           endPoint: .bottom)
        case .leftCross:
            
            return LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                           startPoint: .bottomLeading,
                           endPoint: .topTrailing)
        case .rightCross:
            
            return LinearGradient(gradient: Gradient(colors: [startColor, endColor]),
                           startPoint: .bottomTrailing,
                           endPoint: .topLeading)
        }
    }
}

struct Shape_Previews: PreviewProvider {
    static var previews: some View {
        Shape(startColor: Color.clear, endColor: Color.black, angle: .horizontal, cornerRadius: 0, lineWidth: 0, lineColor: Color.red)
    }
}
enum ShapeAngle {
    case horizontal
    case vertical
    case leftCross
    case rightCross
}
