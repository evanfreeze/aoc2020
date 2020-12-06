import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let input = rawInput
    .trimmingCharacters(in: .newlines)
    .components(separatedBy: "\n\n")
  
// PART 1

let yesAnswers = input.map({ $0.components(separatedBy: .newlines).joined() })
   
var groupTotals = [Int]()

for answer in yesAnswers {
    var charSet = Set<Character>()
    for character in answer {
        charSet.insert(character)
    }
    groupTotals.append(charSet.count)
}

let result = groupTotals.reduce(0, +)

print("PART 1: Total yes answers across all groups is \(result)")

// PART 2

let yesesByGroup = input.map({ $0.components(separatedBy: .newlines) })

var yesCountPerGroup = [Int]()

for groupAnswers in yesesByGroup {
    var questionsAnsweredYesByEveryoneInGroup = 0
    
    for questionLetter in groupAnswers.first! {
        if groupAnswers.allSatisfy({ $0.contains(questionLetter) }) {
            questionsAnsweredYesByEveryoneInGroup += 1
        }
    }
    
    yesCountPerGroup.append(questionsAnsweredYesByEveryoneInGroup)
}

let p2result = yesCountPerGroup.reduce(0, +)

print("PART 2: Questions answered yes by everyone in group is \(p2result)")
