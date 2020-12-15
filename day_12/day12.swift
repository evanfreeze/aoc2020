import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

// PART 1

enum Instruction: String {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
    case left = "L"
    case right = "R"
    case forward = "F"
}

let rotationMap: [Int: Instruction] = [
    90: .east,
    0: .north,
    270: .west,
    180: .south,
]

func processInstruction(_ item: (instruction: Instruction, amount: Int)) {
    switch item.instruction {
    case .north:
        location.1 += item.amount
    case .south:
        location.1 -= item.amount
    case .east:
        location.0 += item.amount
    case .west:
        location.0 -= item.amount
    case .left:
        if item.amount.isMultiple(of: 90) {
            direction -= item.amount
            if direction < 0 {
                direction += 360
            }
        } else {
            print("non-90-degree right rotations not supported")
        }
    case .right:
        if item.amount.isMultiple(of: 90) {
            direction += item.amount
        } else {
            print("non-90-degree right rotations not supported")
        }
    case .forward:
        print(direction)
        let directionToGo = rotationMap[direction % 360]!
        processInstruction((instruction: directionToGo, item.amount))
    }
}

func calcManhattanDistance(pointA: (Int, Int), pointB: (Int, Int)) -> Int {
    abs(pointA.0 - pointB.0) + abs(pointA.1 + pointB.1)
}

let input = rawInput
    .trimmingCharacters(in: .newlines)
    .components(separatedBy: .newlines)
    .map({ (
        instruction: Instruction(rawValue: String($0.prefix(1)))!,
        amount: Int($0.suffix(from: $0.index(after: $0.startIndex)))!
    ) })

var location = (0, 0)
var direction = 90

for item in input {
    processInstruction(item)
}

let result = calcManhattanDistance(pointA: (0, 0), pointB: location)

print("PART 1: Manhattan Distance from starting point is \(result)")
