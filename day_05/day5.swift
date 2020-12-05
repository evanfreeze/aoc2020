import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let input = rawInput
    .trimmingCharacters(in: .newlines)
    .components(separatedBy: .newlines)

// PART 1

func followInstructions(_ input: String, startingLow: Int, startingHigh: Int, down: Character, up: Character) -> Int {
    var low = startingLow
    var high = startingHigh
    for i in 0..<input.count {
    	let instruction = input[input.index(input.startIndex, offsetBy: i)]
    	if instruction == down {
    		high = high - Int((Double(high - low) / 2).rounded(.up))
    	}
    	if instruction == up {
    		low = low + Int((Double(high - low) / 2).rounded(.down))
    	}
    }
    return high
}

func getSeatId(_ input: String) -> Int {
    let row = followInstructions(String(input.prefix(7)), startingLow: 0, startingHigh: 127, down: "F", up: "B")
    let column = followInstructions(String(input.suffix(3)), startingLow: 0, startingHigh: 7, down: "L", up: "R")
    let id = row * 8 + column
    return id
}

var highId = 0

for instruction in input {
    let id = getSeatId(instruction)
    
    if id > highId {
        highId = id
    }
}

print("PART 1: The highest ID value is \(highId)")



