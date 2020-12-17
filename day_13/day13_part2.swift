import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

let busIntervals = input[1]
    .components(separatedBy: ",")
    .map({ Int($0) ?? nil })

let maxInterval = (busIntervals.filter({ $0 != nil }) as! [Int]).max()!
let indexOfMax = busIntervals.firstIndex(of: maxInterval)!

var runningTime = maxInterval - indexOfMax

var multiple = runningTime / busIntervals[0]!

func checkMultiple(_ numbers: [Int?]) -> Bool {
    for (index, number) in numbers.enumerated() {
        if number != nil {
            let time = numbers[indexOfMax]! * multiple + (index - indexOfMax)
            if !time.isMultiple(of: number!) {
                return false
            }
        } else {
            continue
        }
    }
    
    return true
}

while !checkMultiple(busIntervals) {
    multiple += 1
}

print(multiple * maxInterval - indexOfMax)

// I never actually got this to finish on the actual input because it's not efficient enough, but it passes all
// the test cases.
