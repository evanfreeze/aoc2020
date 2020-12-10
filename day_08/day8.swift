import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).enumerated().map(makeInstruction)

func makeInstruction(i: Int, text: String) -> (instruction: String, value: Int, index: Int) {
    let split = text.components(separatedBy: .whitespaces)
    let ins = split[0]
    let val = Int(split[1])!
    return (instruction: ins, value: val, index: i)
}

// PART 1
func runProgram(with instructions: [(instruction: String, value: Int, index: Int)]) -> (Int, String) {
    var accumulator = 0
    var cursor = 0
    var pastIndexes = [Int]()

    while (0..<instructions.count).contains(cursor) {
        if pastIndexes.contains(cursor) {
            return (accumulator, "infinite")
        }

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

    return (accumulator, "success")
}

let result = runProgram(with: input)
print("PART 1: \(result)")

let jmpNopInstructions = input.filter({ $0.instruction == "jmp" || $0.instruction == "nop" })

for instruction in jmpNopInstructions {
    var program = input
    let newVal = instruction.instruction == "jmp" ? "nop" : "jmp"
    program[instruction.index] = (instruction: newVal, value: instruction.value, index: instruction.index)

    let result = runProgram(with: program)

    if result.1 == "success" {
        print("PART 2: Accumulator on successful exit was \(result.0)")
    }
}
