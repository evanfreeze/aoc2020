import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map({ Int($0)! })

func checkIfValid(number: Int, using group: ArraySlice<Int>) -> Bool {
    for (i, first) in group.enumerated() {
        for (j, second) in group.enumerated() {
            if i == j || first + second != number {
                continue
            }

            return true
        }
    }

    return false
}

let results = input.enumerated().first(where: { (index: Int, number: Int) -> Bool in
    if index < 25 { return false }
    let start = index - 25
    let end = index - 1
    let rangeToCheck = start...end
    let valid = checkIfValid(number: number, using: input[rangeToCheck])
    return !valid
})

print(results ?? "All numbers are valid")
