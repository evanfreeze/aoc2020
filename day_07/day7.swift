import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

// PART 1

struct Bag {
    let name: String
    var contents = [Bag]()
}

func createBag(startingAt line: String, allOptions: [String]) -> Bag {
    let split = line.components(separatedBy: " bags contain ")
    let name = split[0]
    let bagNamesInside = split[1]
        .trimmingCharacters(in: .punctuationCharacters)
        .trimmingCharacters(in: .letters)
        .components(separatedBy: ", ")
        .map({ $0
            .trimmingCharacters(in: .whitespaces)
            .components(separatedBy: .whitespaces)
            .filter({ !$0.contains("bag") && Int($0) == nil })
            .joined(separator: " ")
        })

    var bag = Bag(name: name, contents: [])

    for bagName in bagNamesInside {
        if let nextNodeName = allOptions.first(where: { $0.hasPrefix(bagName) }) {
            bag.contents.append(createBag(startingAt: nextNodeName, allOptions: allOptions))
        }
    }

    return bag
}

func createBagGraph(from input: String) -> Bag {
    let lines = input.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)
    var graph = Bag(name: "root")

    for line in lines {
        graph.contents.append(createBag(startingAt: line, allOptions: lines))
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

print("PART 1: Number of bags that could hold shiny gold is \(result.count)")
