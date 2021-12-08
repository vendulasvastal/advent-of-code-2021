#!/usr/bin/swift

import Foundation

guard let input = readLine()?.components(separatedBy: ",").compactMap(Int.init).sorted() else { exit(0) }

let meanUp: Int = Int((Double(input.reduce(0, +)) / Double(input.count)).rounded(.up))
let meanDown: Int = Int((Double(input.reduce(0, +)) / Double(input.count)).rounded(.down))
print("up", meanUp, "down", meanDown)

let i1 = input.map { abs($0-meanUp) }.map { ($0 * ($0 + 1))/2 }.reduce(0, +)
let i2 = input.map { abs($0-meanDown) }.map { ($0 * ($0 + 1))/2 }.reduce(0, +)

print(i1, i2)

print(min(i1, i2))
