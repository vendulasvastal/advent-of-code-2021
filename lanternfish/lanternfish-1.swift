#!/usr/bin/swift

import Foundation

guard let input = readLine() else { exit(0) }

var timers = input.components(separatedBy: ",").compactMap(Int.init)

var day = 0

var counts: [Int] = .init(repeating: 0, count: 9)

timers.forEach {
    counts[$0] += 1
}

while day != 256 {
    let zeros = counts[0]
    for i in stride(from: 0,through: 7,by: 1) {
        counts[i] = counts[i+1]
    }
    counts[6] += zeros
    counts[8] = zeros
    
    day += 1
    print(day, counts)
}

print(counts.reduce(0, +))
#imageLiteral(resourceName: "kop1-2.pdf")#imageLiteral(resourceName: "kop1.pdf")#imageLiteral(resourceName: "zaloha.pdf")
