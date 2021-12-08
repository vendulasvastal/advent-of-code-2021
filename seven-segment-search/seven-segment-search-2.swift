#!/usr/bin/swift

import Foundation

enum Components: Int, Hashable {
    case mid, top, bottom, topLeft, topRight, bottomLeft, bottomRight
}

let mapping: [Set<Int>: String] = [
    [5,7]: "1",
    [1,2,3,5,6]: "2",
    [1,2,3,5,7]: "3",
    [1,5,7,4]: "4",
    [4,7,1,2,3]: "5",
    [7,4,6,1,2,3]: "6",
    [2,5,7]: "7",
    [1,2,3,4,5,6,7]: "8",
    [4,1,2,3,5,7]: "9",
    [2,3,4,5,6,7]: "0"
]

var sum: Int = 0

while let line = readLine()?.components(separatedBy: " | ") {
    let input = line[0].components(separatedBy: " ")
    let output = line[1].components(separatedBy: " ")
    var map: [Character: Int] = ["a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0]
    var mapKnown: [Character: Int] = ["a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0]
    input.forEach { number in
        number.forEach { char in
            if number.count == 2 || number.count == 3 || number.count == 4 || number.count == 7 {
                mapKnown[char]! += 1
            } else {
                map[char]! += 1
            }
        }
    }
    
    let value: String = output.compactMap { number -> String? in
        let arr = number.map { character -> Int in
            let known = mapKnown[character]!
            let unknown = map[character]!
            let sum = known + unknown
            if sum == 4 { return 6 }
            if sum == 6 { return 4 }
            if sum == 9 { return 7 }
            if sum == 7 {
                if known == 2 { return 1 }
                if known == 1 { return 3 }
            }
            if known == 4 { return 5 }
            else { return 2 }
        }
        return mapping[Set(arr)]
    }.joined()
    
    sum += Int(value) ?? 0
}

print(sum)

//mid - 1
//top - 2
//bottom - 3
//topLeft - 4
//topRight - 5
//bottomLeft - 6
//bottomRight - 7

//
//bottomLeft = 8   2,6,0 = 1+3=4
//
//mid = 4,8    5,2,3,9,6 = 2+5=7
//
//topRight = 4,1,8,7   2,3,9,0 = 4+4=8
//
//topLeft = 4,8,  5,9,6,0 = 2+4=6
//
//bottom = 8  5,2,3,9,6,0 = 1+6=7
//
//top = 8,7  5,2,3,9,6,0 = 2+6=8
//
//bottomRight = 8,7,1,4  5,3,9,6,0 = 4+5=9


