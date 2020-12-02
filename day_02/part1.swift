import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
	fatalError("Failed to load input file")
}

let inputs = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

func checkValidPassword(_ clue: String) -> Bool {
	let parts = clue.components(separatedBy: .whitespaces)
	let startEndValues = parts[0].components(separatedBy: "-")
	let range = Int(startEndValues[0])!...Int(startEndValues[1])!
	let character = parts[1].first!
	let password = parts[2]
	
	let matches = password.filter({ $0 == character })
	
	return range.contains(matches.count)
}

var validCount = 0

for input in inputs {
	if checkValidPassword(input) {
		validCount += 1
	}
}

print("Total valid passwords: \(validCount)")
