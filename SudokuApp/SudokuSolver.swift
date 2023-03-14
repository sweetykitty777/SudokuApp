//
//  SudokuSolver.swift
//  SudokuApp
//  algorithm source: https://habr.com/ru/post/192102/, https://grandgames.net/info/sudoku_alex
//  Created by Olga on 11.03.2023.
//

class SudokuSolver {

    private var myMatrix: [[Int]]
    
    init(matrix: [[Int]]) {
        self.myMatrix = matrix
    }
    
    public func setMatrix(matrix: [[Int]]) {
        self.myMatrix = matrix
    }
    public func getMatrix() -> [[Int]]{
        return myMatrix
    }
    
    public func solveSudoku() -> Bool {
        var x = 0, y = 0
        if (!emptyCellCheck(row: &x, col: &y)) {
            return true
        }
        for num in 1...9 {
            if (canWePutN(x: x, y: y, num: num)) {
                myMatrix[x][y] = num
                if (solveSudoku()) {
                    return true
                }
                myMatrix[x][y] = 0
            }
        }
        return false
    }
    
    public func canWePutN(x: Int, y: Int, num: Int) -> Bool {
        for i in 0..<9 {
            if (myMatrix[i][y] == num || myMatrix[x][i] == num) {
                return false
            }
        }
        for i in 0..<3 {
            for j in 0..<3 {
                if (myMatrix[i + x - x % 3][j + y - y % 3] == num) {
                    return false
                }
            }
        }
        return true
    }
    
    public func numberForSolution(number: inout Int, row: inout Int, col: inout Int) {
        var poses: [[Int]] = [[0, 0, 0],
                               [0, 0, 0],
                               [0, 0, 0]]
        
        for h in 0...2 {
            for k in 0...2 {
                var nums = [false, false, false, false, false, false, false, false ,false]
                for i in 0...2 {
                    for j in 0...2 {
                        poses[i][j] = myMatrix[h * 3 + i][k * 3 + j]
                        if (poses[i][j] != 0) {
                            nums[poses[i][j] - 1] = true
                        }
                    }
                }
                for num in 0...8 {
                    if (!nums[num]) {
                        let coords = checkAvailablePlace(poses, num + 1, h, k)
                        if (coords != (-1, -1)) {
                            number = num + 1
                            row = h * 3 + coords.row
                            col = k * 3 + coords.col
                            return
                        }
                    }
                }

            }
        }
        
        for i in 0...8 {
            var nums = [false, false, false, false, false, false, false, false ,false]
            let arr = myMatrix[i]
            for j in 0...8 {
                if (arr[j] != 0) {
                    nums[arr[j] - 1] = true
                }
            }
            for num in 0...8 {
                if (!nums[num]) {
                    let coords = availableinRow(arr, num + 1, i)
                    if (coords != (-1, -1)) {
                        number = num + 1
                        row = i
                        col = coords.col
                        return
                    }
                }
            }
        }
        
        for j in 0...8 {
            var nums = [false, false, false, false, false, false, false, false, false]
            var arr: [Int] = []
            for i in 0...8 {
                arr.append(myMatrix[i][j])
                if (myMatrix[i][j] != 0) {
                    nums[myMatrix[i][j] - 1] = true
                }
            }
            for num in 0...8 {
                if (!nums[num]) {
                    let coords = uniquePlaceColumn(arr, num + 1, j)
                    if (coords != (-1, -1)) {
                        number = num + 1
                        row = coords.row
                        col = j
                        return
                    }
                }
            }
        }
    }
    

    private func emptyCellCheck(row: inout Int, col: inout Int) -> Bool {
        for i in 0..<9 {
            for j in 0..<9 {
                if (myMatrix[i][j] == 0) {
                    row = i
                    col = j
                    return true
                }
            }
        }
        return false
    }
    
    public func getSudokuMatrix(_ requirrments: Int) -> [[Int]] {
        var myArray = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
        let solver = SudokuSolver(matrix: myMatrix)
        var hardness = 81
        var positions: [Int] = []
        for i in 0..<81 {
            positions.append(i)
        }
        positions.shuffle()
        for i in 0..<81 {
            let x = positions[i] / 9;
            let y = positions[i] % 9
            if myArray[x][y] == 0 {
                myArray[x][y] = 1
                let temp = myMatrix[x][y]
                myMatrix[x][y] = 0
                hardness -= 1
                solver.setMatrix(matrix: myMatrix)
                var check = 0
                solver.countSolutions(number: &check)
            
            if (check != 1) {
                myMatrix[x][y] = temp
                hardness += 1
            }
            
            if (hardness <= requirrments) {
                break
            }
            }
        }
        return myMatrix
    }
    
    private func countSolutions(number: inout Int) {
        var x = 0, y = 0
        if (!emptyCellCheck(row: &x, col: &y)) {
            number += 1
            return
        }
        var numbers: [Int] = []
        for i in 1...9 {
            numbers.append(i)
        }
        numbers.shuffle()
        for i in 0..<9 {
            if (number >= 2) {
                break
            }
            if (canWePutN(x: x, y: y, num: numbers[i])) {
                myMatrix[x][y] = numbers[i];
                
                countSolutions(number: &number);
            }
            myMatrix[x][y] = 0;
        }
    }
    
    private func uniquePlaceColumn(_ arr: [Int], _ num: Int, _ col: Int) -> (row: Int, col: Int) {
        var line = arr
        for i in 0...8 {
            if (line[i] == 0 && !canWePutN(x: i, y: col, num: num)) {
                line[i] = -1
            }
        }
        var count = 0
        var coords_to_return = (-1, -1)
        for i in 0...8 {
            if (line[i] == 0) {
                count += 1
                coords_to_return = (i, col)
            }
         }
        if (count == 1) {
            return coords_to_return
        }
        return (-1, -1)
    }
    
    private func availableinRow(_ arr: [Int], _ num: Int, _ row: Int) -> (row: Int, col: Int) {
        var line = arr
        for i in 0...8 {
            if (line[i] == 0 && !canWePutN(x: row, y: i, num: num)) {
                line[i] = -1
            }
        }
        var count = 0
        var coords_to_return = (-1, -1)
        for i in 0...8 {
            if (line[i] == 0) {
                count += 1
                coords_to_return = (row, i)
            }
        }
        if (count == 1) {
            return coords_to_return
        }
        return (-1, -1)
    }
    
    private func checkAvailablePlace(_ sq: [[Int]], _ num: Int, _ area_row: Int, _ area_col: Int) -> (row: Int, col: Int) {
        var square = sq
        for i in 0...2 {
            for j in 0...2 {
                if (square[i][j] == 0 && !canWePutN(x: area_row * 3 + i, y: area_col * 3 + j, num: num)) {
                    square[i][j] = -1
                }
            }
        }
        
        var count = 0
        var coord_to_return = (-1, -1)
        for i in 0...2 {
            for j in 0...2 {
                if (square[i][j] == 0) {
                    count += 1
                    coord_to_return = (i, j)
                }
            }
        }
        if (count == 1) {
            return coord_to_return
        }
        return (-1, -1)
    }
    
    
}
