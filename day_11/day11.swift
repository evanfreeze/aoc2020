import Foundation

guard let rawInput = try? String(contentsOfFile: "./input.txt", encoding: .utf8) else {
    fatalError("Failed to load input file")
}

let seat = "🪑"
let floor = "⬜️"
let person = "😷"

let input = rawInput.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map {
    $0.map {
        $0 == "L" ? seat : floor
    }
}

var part1Map = input

func calculateNeighborCount(row: Int, col: Int, map: [[String]]) -> Int {
	let cols = (min: 0, max: map[0].count - 1)
	let rows = (min: 0, max: map.count - 1)
	
	let left = col > cols.min ? map[row][col - 1] : nil
	let right = col < cols.max ? map[row][col + 1] : nil
	let up = row > rows.min ? map[row - 1][col] : nil
	let down = row < rows.max ? map[row + 1][col] : nil
	let upLeft = col > cols.min && row > rows.min ?  map[row - 1][col - 1] : nil
	let upRight = col < cols.max && row > rows.min ?  map[row - 1][col + 1] : nil
	let dnLeft = col > cols.min && row < rows.max ?  map[row + 1][col - 1] : nil
	let dnRight = col < cols.max && row < rows.max ?  map[row + 1][col + 1] : nil
	
	var neighborCount = 0
	
	for space in [left, right, up, down, upLeft, upRight, dnLeft, dnRight] {
		if space != nil && space! == person {
			neighborCount += 1
		}
	}
	
	return neighborCount
}

var changes = 1

var counter = 0
var currentMap = input

// currentMap.map { print($0) }

while changes != 0 {
	// print("—————— STARTING SHUFFLE! —————")
	var mapCopy = currentMap
	var changesThisRun = 0
	
	for rowIndex in 0..<currentMap.count {
		for columnIndex in 0..<currentMap[rowIndex].count {
			let currentSpot = currentMap[rowIndex][columnIndex]
			let neighbors = calculateNeighborCount(row: rowIndex, col: columnIndex, map: currentMap)
			
			if currentSpot == seat && neighbors == 0 {
				mapCopy[rowIndex][columnIndex] = person
				changesThisRun += 1
			} else if currentSpot == person && neighbors >= 4 {
				mapCopy[rowIndex][columnIndex] = seat
				changesThisRun += 1
			}
		}
	}
	
	changes = changesThisRun
	currentMap = mapCopy
	// currentMap.map { print($0) }
	counter += 1
}

var 😷 = 0

for row in currentMap {
	for column in row {
		if column == person {
			😷 += 1
		}
	}
}

print(😷)
