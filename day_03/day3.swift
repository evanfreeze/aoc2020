import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
	fatalError("Failed to load input file")
}

let input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map({ $0.map({ String($0) }) })

// PART 1

func countTrees(in matrix: [[String]], rise: Int, run: Int) -> Int {
	var trees = 0
	var nextPoint = (x: 0, y: 0)
	var nextPointExists = true
	
	while nextPointExists {
		if matrix[nextPoint.y][nextPoint.x] == "#" {
			trees += 1
		}
		
		nextPoint.x += run
		nextPoint.y += rise
		
		if !matrix[0].indices.contains(nextPoint.x) {
			nextPoint.x = nextPoint.x - matrix[0].count
		}
		
		if !matrix.indices.contains(nextPoint.y) {
			nextPointExists = false
		}
	}
	
	return trees
}

let result = countTrees(in: input, rise: 1, run: 3)
print("PART 1: You'd encounter \(result) trees")

// PART 2

let slopes = [
	(right: 1, down: 1),
	(right: 3, down: 1),
	(right: 5, down: 1),
	(right: 7, down: 1),
	(right: 1, down: 2),
]

var treesPerSlope = [Int]()

for slope in slopes {
	let resultForSlope = countTrees(in: input, rise: slope.down, run: slope.right)
	treesPerSlope.append(resultForSlope)
}

let productOfSlopes = treesPerSlope.reduce(1, *)
print("PART 2: Product of slopes is \(productOfSlopes)")
