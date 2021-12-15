#!/usr/bin/swift

import Foundation

let start = "start"
let end = "end"
var neighbours: [String: [String]] = [:]
var visited: Set<String> = []
var paths: Int = 0

func addNeighbours(_ n1: String, n2: String) {
    if neighbours[n1] == nil {
        neighbours[n1] = [n2]
    } else {
        neighbours[n1]?.append(n2)
    }
}

func visit(_ cave: String) {
    if cave == end {
        paths += 1
        return
    }
    if cave.first!.isLowercase {
        visited.insert(cave)
    }
    for neighbour in neighbours[cave] ?? [] {
        if !visited.contains(neighbour) {
            visit(neighbour)
            visited.remove(neighbour)
        }
    }
}

while let line = readLine()?.components(separatedBy: "-") {
    addNeighbours(line[0], n2: line[1])
    if line[1] != end && line[0] != start {
        addNeighbours(line[1], n2: line[0])
    }
}

visit(start)

print(neighbours)

print(paths)
