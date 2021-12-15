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

var maxX: Int = 0
var maxY: Int = 0

while let line = readLine() {
    if line.isEmpty { break }
    let point = line.components(separatedBy: ",").compactMap(Int.init)
    let x = point[0]
    let y = point[1]
    maxX = max(maxX, x)
    maxY = max(maxY, y)
    points.insert(Point(x: x, y: y))
}

if let line = readLine()?.components(separatedBy: " ") {
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

print(maxX, maxY)
print(points.count)
