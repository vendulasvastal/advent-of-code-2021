#!/usr/bin/swift

import Foundation

var counter = 0
while let line = readLine()?.components(separatedBy: " | ") {
    let input = line[0]
    let output = line[1].components(separatedBy: " ")
    
    counter += output.filter {
        $0.count == 2 || $0.count == 3 || $0.count == 4 || $0.count == 7
    }.count
}

print(counter)
