import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map(makeInstruction)

func makeInstruction(_ text: String) -> (instruction: String, value: Int) {
    let split = text.components(separatedBy: .whitespaces)
    let ins = split[0]
    let val = Int(split[1])!
    return (instruction: ins, value: val)
}

// PART 1

func runProgram(with instructions: [(instruction: String, value: Int)]) -> Int {
    var accumulator = 0
    var cursor = 0
    var pastIndexes = [Int]()
    
    while !pastIndexes.contains(cursor) {
        pastIndexes.append(cursor)
        
        let currentLine = instructions[cursor]
        
        switch currentLine.instruction {
        case "nop":
            cursor += 1
        case "acc":
            accumulator += currentLine.value
            cursor += 1
        case "jmp":
            cursor += currentLine.value
        default:
            fatalError("Encountered unknown instruction: \(currentLine.instruction)")
        }
    }
    
    return accumulator
}

let result = runProgram(with: input)
print("PART 1: \(result)")
