#!/usr/bin/swift

import Foundation

var position = 0
var depth = 0
while let line = readLine() {
    let components = line.components(separatedBy: " ")
    let move = components[0]
    let value = Int(components[1])!
    switch move {
    case "forward":
        position += value
    case "down":
        depth += value
    case "up":
        depth -= value
    default:
        break
    }
}

print(position * depth)
