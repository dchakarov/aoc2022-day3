//
//  main.swift
//  No rights reserved.
//

import Foundation
import Algorithms

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
    
    solve1(lines: lines)
    solve2(lines: lines)
}

func solve1(lines: [String]) {
    var duplicatedItems = 0
    
    lines.forEach { line in
        let rucksack = parseLine(line)
        let c1 = Set(rucksack.c1)
        let c2 = Set(rucksack.c2)
        let result = c1.intersection(c2)
        duplicatedItems += result.map { alphaDictionary[String($0)]! }.reduce(0, +)
    }
    
    print(duplicatedItems)
}

func solve2(lines: [String]) {
    let groups = lines.map(Set.init).chunks(ofCount: 3).map(Array.init)
    var priority = 0
    for group in groups {
        priority += group[0].intersection(group[1]).intersection(group[2])
            .map { alphaDictionary[String($0)]! }
            .reduce(0, +)
    }
    print(priority)
}


var alphaDictionary: [String: Int] {
    let alphabet: [String] = [
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    ]
    var result = [String: Int]()
    var i = 1
    for letter in alphabet {
        result[letter] = i
        i += 1
    }
    return result
}

func parseLine(_ line: String) -> (c1: [Character], c2: [Character]) {
    let rucksack = Array(line)
    let compartment1 = Array(rucksack.dropLast(rucksack.count/2))
    let compartment2 = Array(rucksack.dropFirst(rucksack.count/2))
    return (compartment1, compartment2)
}

main()
