#!/usr/bin/swift

import Foundation

let start = "start"
let end = "end"
var neighbours: [String: [String]] = [:]
var visitedCount: [String: Int] = [:]
var paths: Int = 0

func addNeighbours(_ n1: String, _ n2: String) {
    if n1 == end || n2 == start { return }
    
    if neighbours[n1] == nil {
        neighbours[n1] = [n2]
    } else {
        neighbours[n1]?.append(n2)
    }
}

func visit(_ cave: String, didVisitTwice: Bool) {
    if cave == end {
        paths += 1
        return
    }
    
    var twice = didVisitTwice

    if cave.first!.isLowercase {
        let visitedCount = visitedCount[cave] ?? 0
        if visitedCount == 1 && didVisitTwice { return }
        if visitedCount == 2 { return }
        if visitedCount == 1 { twice = true }
    }
    
    visitedCount[cave] = (visitedCount[cave] ?? 0) + 1
    
    for neighbour in neighbours[cave] ?? [] {
        visit(neighbour, didVisitTwice: twice)
    }
    
    visitedCount[cave] = (visitedCount[cave] ?? 0) - 1
}

while let line = readLine()?.components(separatedBy: "-") {
    addNeighbours(line[0], line[1])
    addNeighbours(line[1], line[0])
}

visit(start, didVisitTwice: false)
print(neighbours)
print(paths)
