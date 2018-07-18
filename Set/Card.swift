//
//  Card.swift
//  Set
//
//  Created by Luke on 7/15/18.
//  Copyright © 2018 Luke Yuan. All rights reserved.
//

import Foundation

struct Card: Equatable {
    // MARK: Constants
    enum Shading {
        case empty
        case striped
        case solid
        
        static var all: [Shading] = [.empty, .striped, .solid]
    }
    
    enum Shape {
        case circle
        case square
        case triangle
        
        static var all: [Shape] = [.circle, .square, .triangle]
    }
    
    enum Color {
        case black
        case blue
        case red
        
        static var all: [Color] = [.black, .blue, .red]
    }
    

    // MARK: Properties
    let number: Int
    let shading: Shading
    let shape: Shape
    let color: Color
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.number == rhs.number && lhs.shading == rhs.shading && lhs.shape == rhs.shape && lhs.color == rhs.color
    }
    
    init(number: Int, shading: Shading, shape: Shape, color: Color) {
        self.number = number
        self.shading = shading
        self.shape = shape
        self.color = color
    }
}
