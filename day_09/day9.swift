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

print("PART 1: First invalid number is: \(results!.element)")

// PART 2

outer: for (index, number) in input.enumerated() {
    let invalidNumber = results!.element
    var sum = number
    var cursor = index
    var numbers = [number]

    while sum <= invalidNumber {
        let nextNumber = input[cursor + 1]
        numbers.append(nextNumber)
        sum += nextNumber
        cursor += 1

        if sum == invalidNumber {
            print("PART 2: Sum of min max of consecutive numbers is \(numbers.min()! + numbers.max()!)")
            break outer
        }
    }
}
