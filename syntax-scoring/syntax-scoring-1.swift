#!/usr/bin/swift

enum Bracket: String {
    case squareL = "["
    case roundL = "("
    case angleL = "<"
    case curlyL = "{"
    case squareR = "]"
    case roundR = ")"
    case angleR = ">"
    case curlyR = "}"
    
    var isClosing: Bool {
        switch self {
        case .squareL, .roundL, .angleL, .curlyL:
            return false
        default:
            return true
        }
    }
    
    var isOpening: Bool { !isClosing }
    
    var points: Int {
        switch self {
        case .roundR:
            return 3
        case .squareR:
            return 57
        case .curlyR:
            return 1197
        case .angleR:
            return 25137
        default:
            return 0
        }
    }
    
    var matching: Bracket {
        switch self {
        case .squareL:
            return .squareR
        case .roundL:
            return .roundR
        case .angleL:
            return .angleR
        case .curlyL:
            return .curlyR
        case .squareR:
            return .squareL
        case .roundR:
            return .roundL
        case .curlyR:
            return .curlyL
        case .angleR:
            return .angleL
        }
    }
}

import Foundation

var points: Int = 0

while var brackets = readLine()?.compactMap({ Bracket(rawValue: String($0)) }) {
    var stack: [Bracket] = []
    while !brackets.isEmpty {
        let bracket = brackets.removeFirst()
        if bracket.isOpening {
            stack.append(bracket)
        } else if bracket.isClosing {
            if stack.isEmpty || bracket.matching != stack.removeLast() {
                points += bracket.points
                break
            }
        }
    }
}

print(points)
