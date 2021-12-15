#!/usr/local/swift

import Foundation

struct Point: Hashable {
    let x: Int
    let y: Int
}

struct Fold {
    let x: Int?
    let y: Int?
}

var points: Set<Point> = []
var folds: [Fold] = []

while let line = readLine() {
    if line.isEmpty { break }
    let point = line.components(separatedBy: ",").compactMap(Int.init)
    points.insert(Point(x: point[0], y: point[1]))
}

while let line = readLine()?.components(separatedBy: " ") {
    let components = line[2].components(separatedBy: "=")
    let value = Int(components[1])
    switch components[0] {
    case "x":
        folds.append(Fold(x: value, y: nil))
    case "y":
        folds.append(Fold(x: nil, y: value))
    default:
        break
    }
}

func foldUp(along y: Int) {
    var removePoints: Set<Point> = []
    var addPoints: Set<Point> = []
    for point in points {
        guard point.y > y else { continue }
        removePoints.insert(point)
        addPoints.insert(Point(x: point.x, y: 2*y - point.y))
    }
    points.subtract(removePoints)
    points.formUnion(addPoints)
}

func foldLeft(along x: Int) {
    var removePoints: Set<Point> = []
    var addPoints: Set<Point> = []
    for point in points {
        guard point.x > x else { continue }
        removePoints.insert(point)
        addPoints.insert(Point(x: 2*x - point.x, y: point.y))
    }
    points.subtract(removePoints)
    points.formUnion(addPoints)
}

for fold in folds {
    if let x = fold.x { foldLeft(along: x) }
    if let y = fold.y { foldUp(along: y) }
}

let countX = (points.max(by: { $0.x < $1.x })?.x ?? 0) + 1
let countY = (points.max(by: { $0.y < $1.y })?.y ?? 0) + 1

var draw = Array(repeating: Array(repeating: " ", count: countX), count: countY)

print(points.count)

for point in points {
    draw[point.y][point.x] = "x"
}

for y in (0..<countY) {
    print(draw[y].joined())
}




