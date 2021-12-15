#!/usr/bin/swift

import Foundation

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}


struct Point: Hashable {
    let i: Int
    let j: Int
    
    init(_ i: Int, _ j: Int) {
        self.i = i
        self.j = j
    }
}

var numbers: [[Int]] = []

while let line = readLine() {
    let row = line.compactMap { Int(String($0)) }
    numbers.append(row)
}

let rows = numbers.count
let cols = numbers[0].count

var lowPoints: [Point] = []

for i in (0..<rows) {
    for j in (0..<cols) {
        let curr = numbers[i][j]
        if i != 0 && numbers[i-1][j] <= curr { continue }
        if j != 0 && numbers[i][j-1] <= curr { continue }
        if i != rows-1 && numbers[i+1][j] <= curr { continue }
        if j != cols-1 && numbers[i][j+1] <= curr { continue }
        lowPoints.append(Point(i,j))
    }
}

var sizes = [0,0,0]

for lowPoint in lowPoints {
    var queue: [Point] = [lowPoint]
    var visited: Set<Point> = [lowPoint]
    var basinSize = 0
    
    
    while !queue.isEmpty {
        basinSize += 1
        let point = queue.removeFirst()
        let i = point.i
        let j = point.j
        
        if i != 0 && numbers[i-1][j] != 9 && !visited.contains(Point(i-1,j)) {
            visited.insert(Point(i-1,j))
            queue.append(Point(i-1,j))
        }
        
        if j != 0 && numbers[i][j-1] != 9 && !visited.contains(Point(i,j-1)) {
            visited.insert(Point(i,j-1))
            queue.append(Point(i,j-1))
        }
        
        if i != rows-1 && numbers[i+1][j] != 9 && !visited.contains(Point(i+1,j)) {
            visited.insert(Point(i+1,j))
            queue.append(Point(i+1,j))
        }
        
        if j != cols-1 && numbers[i][j+1] != 9 && !visited.contains(Point(i,j+1)) {
            visited.insert(Point(i,j+1))
            queue.append(Point(i,j+1))
        }
    }
    
    sizes[0] = max(sizes[0], basinSize)
    sizes.sort()
}

print(sizes.reduce(1, *))
