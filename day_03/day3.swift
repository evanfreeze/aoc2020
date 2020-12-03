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
print("You'd encounter \(result) trees")
