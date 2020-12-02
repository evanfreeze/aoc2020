import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
	fatalError("Failed to load input file")
}

let inputs = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

func checkValidPassword(_ clue: String) -> Bool {
	let parts = clue.components(separatedBy: .whitespaces)
	let startEndValues = parts[0].components(separatedBy: "-")
	let character = parts[1].first!
	let password = parts[2]
	
	let firstIndex = Int(startEndValues[0])! - 1
	let secondIndex = Int(startEndValues[1])! - 1
	
	let charAtFirstPosition = password[password.index(password.startIndex, offsetBy: firstIndex)]
	let charAtSecondPosition = password[password.index(password.startIndex, offsetBy: secondIndex)]
	
	let matchesFirst = charAtFirstPosition == character
	let matchesSecond = charAtSecondPosition == character
	
	if matchesFirst && matchesSecond {
		return false
	} else if matchesFirst || matchesSecond {
		return true
	} else {
		return false
	}
}

var validCount = 0

for input in inputs {
	if checkValidPassword(input) {
		validCount += 1
	}
}

print("Total valid passwords: \(validCount)")
