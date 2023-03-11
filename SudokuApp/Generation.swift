//
//  Generation.swift
//  SudokuApp
//
//  Created by Olga on 09.03.2023.
//

/*public class Generation {
    public func generateSudoku() -> (question: [[Int]]?, answer: [[Int]]?) {
        var sudoku = [[Int]]()
        
        // Заполнение судоку случайными числами
        for i in 0..<9 {
            var row = [Int]()
            for j in 0..<9 {
                let num = Int.random(in: 1...9)
                row.append(num)
            }
            sudoku.append(row)
        }
        var solutions = [[[Int]]]()
        // Удаление цифр из судоку
        for i in 0..<9 {
            for j in 0..<9 {
                let num = sudoku[i][j]
                sudoku[i][j] = 0
                
                // Проверка, что судоку имеет только одно решение
                 solutions = solveSudoku(sudoku: sudoku)
                if solutions.count != 1 {
                    sudoku[i][j] = num
                }
            }
        }
        return (sudoku, solutions[0])
    }

    // Алгоритм поиска решения судоку с использованием "глубокого копирования"
    func solveSudoku(sudoku: [[Int]]) -> [[[Int]]] {
        var solutions = [[[Int]]]()
        var board = sudoku
        
        solveSudokuHelper(&board, 0, 0, &solutions)
        
        return solutions
    }

    func solveSudokuHelper(_ board: inout [[Int]], _ row: Int, _ col: Int, _ solutions: inout [[[Int]]]) {
        // Проверка, что судоку решена
        if row == 9 {
            solutions.append(board)
            return
        }
        
        // Поиск следующей пустой клетки
        var nextRow = row
        var nextCol = col + 1
        if nextCol == 9 {
            nextRow += 1
            nextCol = 0
        }
        
        // Если текущая клетка не пустая, переход к следующей
        if board[row][col] != 0 {
            solveSudokuHelper(&board, nextRow, nextCol, &solutions)
            return
        }
        
        // Попытка заполнить текущую клетку
        for num in 1...9 {
            if isValid(board, row, col, num) {
                board[row][col] = num
                solveSudokuHelper(&board, nextRow, nextCol, &solutions)
                board[row][col] = 0
            }
        }
    }

    // Проверка, что число может быть размещено в данной клетке
    func isValid(_ board: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        // Проверка строки и столбца
        for i in 0..<9 {
            if board[row][i] == num || board[i][col] == num {
                return false
            }
        }
        
        // Проверка блока 3x3
        let blockRow = (row / 3) * 3
        let blockCol = (col / 3) * 3
        for i in blockRow..<blockRow+3 {
            for j in blockCol..<blockCol+3 {
                if board[i][j] == num {
                    return false
                }
            }
        }
        return true
   }
    
    public func getSudoku() {
        var sudoku = generateSudoku().question
        for i in 0..<9 {
            for j in 0..<9 {
                print(sudoku?[i][j])
            }
            print("\n")
        }
    }
}*/
