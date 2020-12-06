import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let yesAnswers = rawInput
    .trimmingCharacters(in: .newlines)
    .components(separatedBy: "\n\n")
    .map({ $0.components(separatedBy: .newlines).joined() })
  
// PART 1
   
var groupTotals = [Int]()

for answer in yesAnswers {
    var charSet = Set<Character>()
    for character in answer {
        charSet.insert(character)
    }
    groupTotals.append(charSet.count)
}

let result = groupTotals.reduce(0, +)

print("PART 1: Total yes answers across all groups is \(result)")
