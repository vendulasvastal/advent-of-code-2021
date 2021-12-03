#!/usr/bin/swift

import Foundation

var report: [String] = []
while let line = readLine() {
    report.append(line)
}
let count = report.count
let length = report.first?.count ?? 0


func filter(report: [String], comparator: (Int, Int) -> Bool) -> String {
    var ones: [String] = []
    var zeros: [String] = []
    var res = report
    var index = 0
    while res.count > 1 {
        ones = res.filter { $0[$0.index($0.startIndex, offsetBy: index)] == "1" }
        zeros = res.filter { $0[$0.index($0.startIndex, offsetBy: index)] == "0" }
        res = comparator(ones.count, zeros.count) ? ones : zeros
        index += 1
    }
    return res.first ?? ""
}

let oxygenGeneratorString = filter(report: report, comparator: >=)
let co2ScrubberString = filter(report: report, comparator: <)

guard let oxygenGeneratorRating = Int(oxygenGeneratorString, radix: 2), let co2ScrubberRating = Int(co2ScrubberString, radix: 2) else { exit(0) }

print(oxygenGeneratorRating * co2ScrubberRating)

