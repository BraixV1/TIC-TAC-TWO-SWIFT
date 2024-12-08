//
//  GameEngine.swift
//  TIC-TAC-TOE-TWO
//
//  Created by Brajan Kukk on 25.11.2024.
//
import Foundation

class GameEngine : ObservableObject {
    @Published public var state: GameState
    
    init(gameState: GameState) {
        self.state = gameState
    }
    
    public func SwitchPlayer() {
        let winner = self.checkWinner()
        if winner != nil {
            self.state.gameover = true
        }
        else {
            self.state.currentPlayer = (self.state.currentPlayer == "X") ? "O" : "X"
        }

        let newState = self.state
        self.state = newState
    }

    
    public func moveActiveGrid(for direction: EDirection) -> Void{
        var validDirection = false
        if (self.state.gameover) {
            return
        }
        switch direction {
        case .up:
            if self.state.activeGridX > 0 {
                self.state.activeGridX = self.state.activeGridX - 1
                validDirection = true
            }
        case .down:
            if self.state.activeGridX < self.state.gridSize - 3 {
                self.state.activeGridX = self.state.activeGridX + 1
                validDirection = true
            }
        case .left:
            if self.state.activeGridY > 0 {
                self.state.activeGridY = self.state.activeGridY - 1
                validDirection = true
            }
        case .right:
            if self.state.activeGridY < self.state.gridSize - 3 {
                self.state.activeGridY = self.state.activeGridY + 1
                validDirection = true
            }
        case .topRight:
            if (self.state.activeGridX > 0) && (self.state.activeGridY < self.state.gridSize - 3){
                self.state.activeGridX = self.state.activeGridX - 1
                self.state.activeGridY = self.state.activeGridY + 1
                validDirection = true
            }
        case .topLeft:
            if (self.state.activeGridY > 0) && (self.state.activeGridX > 0) {
                self.state.activeGridX -= 1
                self.state.activeGridY -= 1
                validDirection = true
            }
        case .bottomLeft:
            if (self.state.activeGridX < self.state.gridSize - 3) && (self.state.activeGridY > 0) {
                self.state.activeGridX += 1
                self.state.activeGridY -= 1
                validDirection = true
            }
        case .bottomRight:
            if (self.state.activeGridX < self.state.gridSize - 3) && (self.state.activeGridY < self.state.gridSize - 3) {
                self.state.activeGridX += 1
                self.state.activeGridY += 1
                validDirection = true
            }
        }
        if (validDirection) {
            self.SwitchPlayer()
        }
    }
    
    public func PlaceSymbol(for index: Int) {
        if self.state.gameover {
            return
        }
        if CellEmpty(for: index) {
            self.state.gridState[index] = (self.state.currentPlayer == "X") ? 1 : 0
            self.SwitchPlayer()
        }
    }
    
    func checkWinner() -> String? {
        // Calculate the indices of the active 3x3 grid
        let startRow = state.activeGridX
        let startCol = state.activeGridY
        let endRow = startRow + 2
        let endCol = startCol + 2
        
        // Collect the symbols in the active grid
        var gridSymbols: [[Int?]] = []
        for row in startRow...endRow {
            var rowSymbols: [Int?] = []
            for col in startCol...endCol {
                let index = row * state.gridSize + col
                rowSymbols.append(state.gridState[index] ?? nil)
            }
            gridSymbols.append(rowSymbols)
        }
        
        // Check rows and columns
        for i in 0..<3 {
            // Check rows
            if let rowValue = gridSymbols[i][0],
               rowValue == gridSymbols[i][1],
               rowValue == gridSymbols[i][2] {
                return rowValue == 1 ? "X" : "O"
            }
            
            // Check columns
            if let colValue = gridSymbols[0][i],
               colValue == gridSymbols[1][i],
               colValue == gridSymbols[2][i] {
                return colValue == 1 ? "X" : "O"
            }
        }
        
        // Check diagonals
        if let diag1Value = gridSymbols[0][0],
           diag1Value == gridSymbols[1][1],
           diag1Value == gridSymbols[2][2] {
            return diag1Value == 1 ? "X" : "O"
        }
        
        if let diag2Value = gridSymbols[0][2],
           diag2Value == gridSymbols[1][1],
           diag2Value == gridSymbols[2][0] {
            return diag2Value == 1 ? "X" : "O"
        }
        
        // No winner
        return nil
    }

    
    public func canMoveSymbol(at index: Int) -> Bool {
        guard let cellValue = self.state.gridState[index] else {
            return false
        }
        
        // X (value 1) can only move moons, O (value 0) can only move suns
        return (self.state.currentPlayer == "X" && cellValue == 1) ||
               (self.state.currentPlayer == "O" && cellValue == 0)
    }
    
    public func CellEmpty(for index: Int) -> Bool {
        return self.state.gridState[index] == nil
    }
    
}
