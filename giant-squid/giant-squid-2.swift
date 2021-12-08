#!/usr/bin/swift

import Foundation

typealias Position = (row: Int, column: Int)

struct Draw {
    let board: Int
    let position: Position
}

class Board: Identifiable {
    private let size = 5
    
    private lazy var rows: [Int] = Array(repeating: 0, count: size)
    private lazy var columns: [Int] = Array(repeating: 0, count: size)
    
    private lazy var matrix: [[Int?]] = Array(repeating: Array(repeating: nil, count: size), count: size)
    
    var markedPositions: [Position] = []
    
    func mark(position: Position) -> Bool {
        rows[position.row] += 1
        columns[position.column] += 1
        matrix[position.row][position.column] = nil
        return rows[position.row] == size || columns[position.column] == size
    }
    
    func update(position: Position, value: Int) {
        matrix[position.row][position.column] = value
    }
    
    func unmarkedSum() -> Int {
        var sum = 0
        for row in matrix {
            for val in row {
                sum += (val ?? 0)
            }
        }
        return sum
    }
}

guard let line = readLine() else { exit(0) }
let input = line.components(separatedBy: ",").compactMap(Int.init)

var boards: [Board?] = []
var boardIndex = -1
var board: Board = Board()
var rowIndex = 0
var numbers: [Int: [Draw]] = [:]

while let line = readLine() {
    if line.isEmpty {
        board = Board()
        boardIndex += 1
        rowIndex = 0
        continue
    }
    
    let row = line.components(separatedBy: " ").compactMap(Int.init)
    
    for (column, value) in row.enumerated() {
        let position = Position(rowIndex, column)
        let draw = Draw(board: boardIndex, position: position)
        board.update(position: position, value: value)
        if numbers[value] == nil {
            numbers[value] = [draw]
        } else {
            numbers[value]?.append(draw)
        }
    }
    
    if rowIndex == 4 { boards.append(board) }
    
    rowIndex += 1
}

var boardsWon = 0

for drawValue in input {
    for draw in numbers[drawValue] ?? [] {
        if boards[draw.board]?.mark(position: draw.position) ?? false {
            boardsWon += 1
            
            if boardsWon == boards.count {
                print((boards[draw.board]?.unmarkedSum() ?? 0) * drawValue)
                exit(0)
            }
            
            boards[draw.board] = nil
        }
    }
}
