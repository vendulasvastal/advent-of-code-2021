#!/usr/local/swift

import Foundation

func hexToBin(_ char: Character) -> String {
    switch char {
    case "0":
        return "0000"
    case "1":
        return "0001"
    case "2":
        return "0010"
    case "3":
        return "0011"
    case "4":
        return "0100"
    case "5":
        return "0101"
    case "6":
        return "0110"
    case "7":
        return "0111"
    case "8":
        return "1000"
    case "9":
        return "1001"
    case "A":
        return "1010"
    case "B":
        return "1011"
    case "C":
        return "1100"
    case "D":
        return "1101"
    case "E":
        return "1110"
    case "F":
        return "1111"
    default: return ""
    }
}

class Packet {
    let typeId: Int
    let version: Int
    let literalValue: Int?
    let subpackets: [Packet]
    
    init(
        typeId: Int,
        version: Int,
        literalValue: Int
    ) {
        self.typeId = typeId
        self.version = version
        self.literalValue = literalValue
        self.subpackets = []
    }
    
    init(
        typeId: Int,
        version: Int,
        subpackets: [Packet]
    ) {
        self.typeId = typeId
        self.version = version
        self.literalValue = nil
        self.subpackets = subpackets
    }
}

guard let line = readLine() else { exit(0) }

let binary = line.compactMap { hexToBin($0) }.joined()
var start = binary.startIndex

func decode(next count: Int) -> Int {
    let end = binary.index(start, offsetBy: count)
    let bits = binary[start..<end]
    start = end
    return Int(bits, radix: 2)!
}

func decodeLiteralValue() -> Int {
    var number = ""
    while true {
        let nEnd = binary.index(start, offsetBy: 5)
        var read = binary[start..<nEnd]
        //print("r", read)
        let first = read.removeFirst()
        number += read
        start = nEnd
        if first == "0" { break }
    }
    return Int(number, radix: 2)!
}

func decodePackets() -> [Packet] {
    let version = decode(next: 3)
    let typeId = decode(next: 3)
    if typeId == 4 {
        return [Packet(typeId: typeId, version: version, literalValue: decodeLiteralValue())]
    } else {
        let lengthTypeId = decode(next: 1)
        var subpackets: [Packet] = []
        if lengthTypeId == 0 {
            let lengthOfSubpackets = decode(next: 15)
            let endIndex = binary.index(start, offsetBy: lengthOfSubpackets)
            while start < endIndex {
                subpackets += decodePackets()
            }
        } else {
            let numberOfSubpackets = decode(next: 11)
            for _ in (1...numberOfSubpackets) {
                subpackets += decodePackets()
            }
        }
        return [Packet(typeId: typeId, version: version, subpackets: subpackets)]
    }
}

let packets = decodePackets()

func versionSum(_ packet: Packet) -> Int {
    var sum = 0
    for subpacket in packet.subpackets {
        sum += versionSum(subpacket)
    }
    return packet.version + sum
}

print(versionSum(packets[0]))
