#!/usr/bin/swift

import Foundation

guard let input = readLine()?.components(separatedBy: ",").compactMap(Int.init).sorted() else { exit(0) }

let median: Int
let middle = input.count / 2
if input.count % 2 == 1 {
    median = input[middle]
} else {
    median = (input[middle - 1] + input[middle]) / 2
}

print(input.map { abs($0-median) }.reduce(0, +))
