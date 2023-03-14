//
//  SudokuGenerator.swift
//  SudokuApp
//  algorithm source: https://habr.com/ru/post/192102/
//  Created by Olga on 11.03.2023.
//

class SudokuGenerator {
    private var oneMatrix: [[Int]] = [
        [1, 2, 3, 4, 5, 6, 7, 8, 9],
        [4, 5, 6, 7, 8, 9, 1, 2, 3],
        [7, 8, 9, 1, 2, 3, 4, 5, 6],
        [2, 3, 4, 5, 6, 7, 8, 9, 1],
        [5, 6, 7, 8, 9, 1, 2, 3, 4],
        [8, 9, 1, 2, 3, 4, 5, 6, 7],
        [3, 4, 5, 6, 7, 8, 9, 1, 2],
        [6, 7, 8, 9, 1, 2, 3, 4, 5],
        [9, 1, 2, 3, 4, 5, 6, 7, 8]]
    func swapRowsArea() {
        var firstArea = Int.random(in: 0..<3)
        var secondArea = Int.random(in: 0..<3)
        while (firstArea == secondArea) {
            secondArea = Int.random(in: 0..<3)
        }
        if (firstArea == 1) {
            firstArea = 3
        }
        if (firstArea == 2) {
            firstArea = 6
        }
        if (secondArea == 1) {
            secondArea = 3
        }
        if (secondArea == 2) {
            secondArea = 6
        }
        for i in 0..<3 {
            for k in 0..<9 {
                let temp = oneMatrix[firstArea + i][k]
                oneMatrix[firstArea + i][k] = oneMatrix[secondArea + i][k]
                oneMatrix[secondArea + i][k] = temp
            }
        }
    }
    func swapColumnsArea() {
        var firstArea = Int.random(in: 0..<3)
        var secondArea = Int.random(in: 0..<3)
        while (firstArea == secondArea) {
            secondArea = Int.random(in: 0..<3)
        }
        if (firstArea == 1) {
            firstArea = 3
        }
        if (firstArea == 2) {
            firstArea = 6
        }
        if (secondArea == 1) {
            secondArea = 3
        }
        if (secondArea == 2) {
            secondArea = 6
        }
        for i in 0..<3 {
            for k in 0..<9 {
                let temp = oneMatrix[k][firstArea + i]
                oneMatrix[k][firstArea + i] = oneMatrix[k][secondArea + i]
                oneMatrix[k][secondArea + i] = temp
            }
        }
    }
    
    func swapRows() {
        var area = Int.random(in: 0..<3)
        if (area == 1) {
            area = 3
        }
        if (area == 2) {
            area = 6
        }
        let firstRow = Int.random(in: 0..<3)
        var secondRow = Int.random(in: 0..<3)
        while (firstRow == secondRow) {
            secondRow = Int.random(in: 0..<3)
        }
        for k in 0..<9 {
            let temp = oneMatrix[area + firstRow][k]
            oneMatrix[area + firstRow][k] = oneMatrix[area + secondRow][k]
            oneMatrix[area + secondRow][k] = temp
        }
    }
    public func getAnswer() -> [[Int]]{
        return oneMatrix
    }
    
    func swapColumns() {
        var area = Int.random(in: 0..<3)
        if (area == 1) {
            area = 3
        }
        if (area == 2) {
            area = 6
        }
        let firstColumn = Int.random(in: 0..<3)
        var secondColumn = Int.random(in: 0..<3)
        while (firstColumn == secondColumn) {
            secondColumn = Int.random(in: 0..<3)
        }
        for k in 0..<9 {
            let temp = oneMatrix[k][area + firstColumn]
            oneMatrix[k][area + firstColumn] = oneMatrix[k][area + secondColumn]
            oneMatrix[k][area + secondColumn] = temp
        }
    }
    
    func transpose() {
        let copy = oneMatrix
        for i in 0..<9 {
            for j in 0..<9 {
                oneMatrix[i][j] = copy[j][i];
            }
        }
    }
    
    func mix() {
        var i = 0
        while (i < 100) {
            var doOrNot = Int.random(in: 0..<2)
            if (doOrNot == 1) {
                transpose()
            }
            doOrNot = Int.random(in: 0..<2)
            if (doOrNot == 1) {
                swapColumns()
            }
            doOrNot = Int.random(in: 0..<2)
            if (doOrNot == 1) {
                swapRows()
            }
            doOrNot = Int.random(in: 0..<2)
            if (doOrNot == 1) {
                swapColumnsArea()
            }
            doOrNot = Int.random(in: 0..<2)
            if (doOrNot == 1) {
                swapRowsArea()
            }
            i += 1
        }
    }
    
    public func getSudokuWithGaps(level: String)-> (question: [[Int]], answer: [[Int]]) {
        mix()
        let solver = SudokuSolver(matrix: oneMatrix)
        var num = 28 // not-gaps num of cells
        if (level == "1") {
            num = 37
        } else if (level == "2") {
            num = 32
        } else if (level == "3") {
            num = 28
        }
        return (solver.getSudokuMatrix(num), solver.getMatrix())
        
    }
}
