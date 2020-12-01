import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let inputNumbers = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map({ Int($0)! })

func calculateResults(_ numbers: [Int]) throws -> String {
    for baseNumber in numbers {
        for firstCheck in numbers {
            if baseNumber == firstCheck { continue }
        
            for secondCheck in numbers {
                if baseNumber == secondCheck || firstCheck == secondCheck { continue }
        
                let sum = baseNumber + firstCheck + secondCheck
                if sum == 2020 {
                    return "Result is \(baseNumber * firstCheck * secondCheck)"
                }
            }
        }
    }
    
    return "No numbers found that meet criteria"
}

let result = try calculateResults(inputNumbers)
print(result)
