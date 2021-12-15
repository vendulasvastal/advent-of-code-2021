#!/usr/local/swift

import Foundation

let moves: [(Int, Int)] = [
    (0,1),
    (0,-1),
    (1,0),
    (-1,0)
]

var rows = 0
var cols = 0

class Vertex: Hashable {
    let row: Int
    let col: Int
    let value: Int
    var distance: Int = Int.max
    
    var neighbours: [(Int,Int)] {
        moves
            .map { (row + $0.0, col + $0.1) }
            .filter { r,c in
                (0..<rows).contains(r) && (0..<cols).contains(c)
            }
    }
    
    init(
        row: Int,
        col: Int,
        value: Int
    ) {
        self.row = row
        self.col = col
        self.value = value
    }
    
    static func == (x: Vertex, y: Vertex) -> Bool {
        x.row == y.row && x.col == y.col
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(row)
        hasher.combine(col)
        hasher.combine(value)
    }
}

var vertices: [[Vertex]] = []
while let line = readLine() {
    vertices.append(line.enumerated().map { index, char in
        Vertex(row: rows, col: index, value: Int(String(char)) ?? 0)
    })
    rows += 1
}
cols = vertices[0].count

vertices[0][0].distance = 0
var openVertices: Set<Vertex> = [vertices[0][0]]

while !openVertices.isEmpty {
    guard let v = openVertices.min(by: { $0.distance < $1.distance }) else { break }
    if v.row == rows-1 && v.col == cols-1 {
        print(v.distance)
        break
    }
    let neighbours = v.neighbours.map { vertices[$0.0][$0.1] }
    for neighbour in neighbours {
        if neighbour.distance > v.distance + neighbour.value {
            neighbour.distance = v.distance + neighbour.value
            openVertices.insert(neighbour)
        }
    }
    openVertices.remove(v)
}
