import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
	fatalError("Failed to load input file")
}

let inputNumbers = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map({ Int($0)! })

func calculateResults(_ numbers: [Int]) -> Int {
	for baseNumber in numbers {
		for checkNumber in numbers {
			if baseNumber == checkNumber {
				continue
			}
			
			let sum = baseNumber + checkNumber
			if sum == 2020 {
				return baseNumber * checkNumber
			}
		}
	}
	
	return -1
}

let result = calculateResults(inputNumbers)
print(result)

