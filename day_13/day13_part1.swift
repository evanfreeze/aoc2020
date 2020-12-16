import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)

let arrivalAtSeaPort = Int(input[0])!
let busIntervals = input[1]
    .components(separatedBy: ",")
    .filter({ $0 != "x" })
    .map({ Int($0)! })

var earliestTime = arrivalAtSeaPort

while true {
    let possibleBuses = busIntervals.filter({ earliestTime.isMultiple(of: $0 )})
    
    if possibleBuses.count > 0 {
        let firstBusId = possibleBuses.first!
        let minutesWaited = earliestTime - arrivalAtSeaPort
        let puzzleAnswer = firstBusId * minutesWaited
        print("""
            PART 1 ——
            • The ID of the first bus you could take is \(firstBusId)
            • You'd have to wait \(minutesWaited) minutes before it arrived
            • Puzzle answer is \(puzzleAnswer)
        """)
        break
    } else {
        earliestTime += 1
    }
}

