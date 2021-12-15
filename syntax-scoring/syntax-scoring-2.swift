#!/usr/bin/swift

import Foundation

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
            return 1
        case .squareR:
            return 2
        case .curlyR:
            return 3
        case .angleR:
            return 4
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

var scores: [Int] = []

while var brackets = readLine()?.compactMap({ Bracket(rawValue: String($0)) }) {
    var score: Int = 0
    var isCorrupted: Bool = false
    var stack: [Bracket] = []
    while !brackets.isEmpty {
        let bracket = brackets.removeFirst()
        if bracket.isOpening {
            stack.append(bracket)
        } else if bracket.isClosing {
            if stack.isEmpty || bracket.matching != stack.removeLast() {
                isCorrupted = true
                break
            }
        }
    }
    
    if isCorrupted { continue }
    while !stack.isEmpty {
        let bracket = stack.removeLast()
        score = score*5 + bracket.matching.points
        if stack.isEmpty { scores.append(score) }
    }
}

scores.sort()

print(scores[scores.count/2])

