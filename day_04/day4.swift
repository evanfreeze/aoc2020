import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
	fatalError("Failed to load input file")
}

let rawPassports = rawInput
	.trimmingCharacters(in: .newlines)
	.components(separatedBy: "\n\n")
	.map({ $0.components(separatedBy: .whitespacesAndNewlines) })

// PART 1

var passports = [[String: String]]()

for passport in rawPassports {
	var passportDict = [String: String]()
	
	for pair in passport {
		let split = pair.components(separatedBy: ":")
		passportDict[split[0]] = split[1]
	}
	
	passports.append(passportDict)
}

let part1Validation = [
    "byr": true,
    "iyr": true,
    "eyr": true,
    "hgt": true,
    "hcl": true,
    "ecl": true,
    "pid": true,
    "cid": false,
]

func validatePassport(_ passport: [String: String], validation: [String: Bool]) -> Bool {
	for (field, required) in validation {
		if required && passport[field] == nil {
			return false
		}
	}
	return true
}

var validPassports = 0

for passport in passports {
	if validatePassport(passport, validation: part1Validation) {
		validPassports += 1
	}
}

print("Part 1: There are \(validPassports) valid passports")

// PART 2

let part2Validation: [String: (String) -> Bool] = [
    "byr": { (_ input: String) -> Bool in
        if let num = Int(input) {
            return (1920...2002).contains(num)
        }
        return false
    },
    "iyr": { (_ input: String) -> Bool in
        if let num = Int(input) {
            return (2010...2020).contains(num)
        }
        return false
    },
    "eyr": { (_ input: String) -> Bool in
        if let num = Int(input) {
            return (2020...2030).contains(num)
        }
        return false
    },
    "hgt": { (_ input: String) -> Bool in
        if input.hasSuffix("cm") {
            var height = input
            height.removeLast(2)
            if let num = Int(height) {
                return (150...193).contains(num)
            }
            return false
        } else if input.hasSuffix("in") {
            var height = input
            height.removeLast(2)
            if let num = Int(height) {
                return (59...76).contains(num)
            }
            return false
        }
        return false
    },
    "hcl": { (_ input: String) -> Bool in
        if input.hasPrefix("#") {
            var color = input
            color.removeFirst(1)
            if Int(color, radix: 16) != nil {
                return true
            }
            return false
        }
        return false
    },
    "ecl": { (_ input: String) -> Bool in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(input) },
    "pid": { (_ input: String) -> Bool in
        if Int(input) != nil {
            return input.count == 9
        }
        return false
    },
    "cid": { (_ input: String) -> Bool in true }
]

func validatePart2(_ passport: [String: String]) -> Bool {
    var results = [Bool]()
    
    for (field, validator) in part2Validation {
        results.append(validator(passport[field] ?? ""))
    }
    
    return results.allSatisfy({ $0 == true })
}

var validPart2Count = 0

for passport in passports {
    if validatePart2(passport) {
        validPart2Count += 1
    }
}

print("Part 2: There are \(validPart2Count) valid passports")
