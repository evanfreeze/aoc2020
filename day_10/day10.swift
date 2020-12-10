import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}


var input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map({ Int($0)! })

var highestJolts = 0
var nextJolt = 1

var oneJoltDiffs = 0
var threeJoltDiffs = 1

while highestJolts + 4 > nextJolt {
    if let indexOfAdapterToUse = input.firstIndex(of: nextJolt) {
        let adapterJolts = input[indexOfAdapterToUse]
        input.remove(at: indexOfAdapterToUse)
        if nextJolt - highestJolts == 1 {
            oneJoltDiffs += 1
        } else if nextJolt - highestJolts == 3 {
            threeJoltDiffs += 1
        }
        highestJolts = adapterJolts
    }

    nextJolt += 1
}

print("PART 1: \(oneJoltDiffs) one jolt diffs, \(threeJoltDiffs) three jolt diffs, product is \(oneJoltDiffs * threeJoltDiffs)")
