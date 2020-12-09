import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

// PART 1

struct Bag {
    let name: String
    let number: Int
    var contents = [Bag]()
}

func createBag(startingAt line: String, number: Int, allOptions: [String]) -> Bag {
    let split = line.components(separatedBy: " bags contain ")
    let name = split[0]
    let bagNamesInsideWithNumbers = split[1]
        .trimmingCharacters(in: .punctuationCharacters)
        .trimmingCharacters(in: .letters)
        .components(separatedBy: ", ")
        .map({ $0
            .trimmingCharacters(in: .whitespaces)
            .components(separatedBy: .whitespaces)
            .filter({ !$0.contains("bag") })
            .joined(separator: " ")
        })

    let bagNamesInside = bagNamesInsideWithNumbers.map({ (input: String) -> (name: String, number: Int) in
        if input == "other" { return (name: input, number: 0) }

        var split = input.components(separatedBy: " ")
        let number = Int(split.removeFirst())!
        let name = split.joined(separator: " ")
        return (name: name, number: number)
    })

    var bag = Bag(name: name, number: number, contents: [])

    for bagTuple in bagNamesInside {
        if let nextNodeName = allOptions.first(where: { $0.hasPrefix(bagTuple.name) }) {
            bag.contents.append(createBag(startingAt: nextNodeName, number: bagTuple.number, allOptions: allOptions))
        }
    }

    return bag
}

func createBagGraph(from input: String) -> Bag {
    let lines = input.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)
    var graph = Bag(name: "root", number: 0)

    for line in lines {
        graph.contents.append(createBag(startingAt: line, number: 0, allOptions: lines))
    }

    return graph
}

func checkIfBagContains(bagName: String, node: Bag) -> Bool {
    let contentsNames = node.contents.map({ $0.name })

    if contentsNames.contains(bagName) {
        return true
    } else if node.contents.count > 0 {
        var contentResults = [Bool]()

        for content in node.contents {
            let contentResult = checkIfBagContains(bagName: bagName, node: content)
            contentResults.append(contentResult)
        }

        return contentResults.contains(true)
    }
    return false
}

func getCountOf(bagName: String, in graph: Bag) -> [Bag] {
    var bagsThatCouldContainInput = [Bag]()

    for bag in graph.contents {
        if checkIfBagContains(bagName: bagName, node: bag) {
            bagsThatCouldContainInput.append(bag)
        }
    }

    return bagsThatCouldContainInput
}

let bagGraph = createBagGraph(from: rawInput)
let result = getCountOf(bagName: "shiny gold", in: bagGraph)

// PART 2

func countSubBagsFor(_ bag: Bag) -> Int {
    if bag.contents.count == 0 {
        return bag.number
    }

    let subValues = bag.contents.map({ countSubBagsFor($0) })
    return bag.number + (max(bag.number, 1) * subValues.reduce(0, +))
}

let shinyGoldNode = bagGraph.contents.first(where: { $0.name == "shiny gold" })
let pt2result = countSubBagsFor(shinyGoldNode!)

print("PART 1: Number of bags that could hold shiny gold is \(result.count)")
print("PART 2: Number of bags inside shiny gold is \(pt2result)")
