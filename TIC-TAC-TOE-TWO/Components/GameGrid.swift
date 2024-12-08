//
//  GameGrid.swift
//  TIC-TAC-TOE-TWO
//
//  Created by Brajan Kukk on 08.12.2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct GameGrid: View {
    @ObservedObject var gameEngine: GameEngine
    @State private var draggedSymbol: String?
    @State private var isDropTargetActive = false
    
    
    var body : some View {
        ForEach(0..<gameEngine.state.gridSize, id: \.self) { row in
            HStack(spacing: 10) {
                ForEach(0..<gameEngine.state.gridSize, id: \.self) { column in
                    let index = row * gameEngine.state.gridSize + column
                    ZStack {
                        gridCellBackground(for: index)
                        if let symbol = CellSymbol(for: index) {
                            imageForSymbol(symbol, in: index)
                        }
                    }
                    .onTapGesture { gameEngine.PlaceSymbol(for: index) }
                    .onDrop(of: [UTType.text], isTargeted: $isDropTargetActive) { providers in
                        handleDrop(providers: providers, to: index)
                    }
                }
            }
        }
    }
    
    private func CellSymbol(for index: Int) -> String? {
        switch gameEngine.state.gridState[index] {
        case .some(1): return "sun"  // Image for "X"
        case .some(0): return "moon" // Image for "O"
        default: return nil
        }
    }
    
    private func returnTurnColor(for player: String) -> Color {
        if player == "X" && gameEngine.state.gameover && gameEngine.state.currentPlayer == "X" {
            return Color.yellow
        }
        else if player == "O" && gameEngine.state.gameover && gameEngine.state.currentPlayer == "O" {
            return Color.yellow
        }
        else if player == gameEngine.state.currentPlayer {
            return Color.blue
        }
        return Color.gray
    }
    

    private func returnColor(for index: Int) -> Color {
        let (row, column) = (index / gameEngine.state.gridSize, index % gameEngine.state.gridSize)
        return isInActiveGrid(row: row, column: column) ? .blue : .gray
    }

    private func isInActiveGrid(row: Int, column: Int) -> Bool {
        let activeStartRow = gameEngine.state.activeGridX
        let activeEndRow = gameEngine.state.activeGridX + 2
        let activeStartCol = gameEngine.state.activeGridY
        let activeEndCol = gameEngine.state.activeGridY + 2
        return row >= activeStartRow && row <= activeEndRow &&
               column >= activeStartCol && column <= activeEndCol
    }
        
    // MARK: - Drag-and-Drop

    // Helper function for the background color of grid cells
    private func gridCellBackground(for index: Int) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(returnColor(for: index))
            .frame(width: 50, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isInActiveGrid(row: index / gameEngine.state.gridSize, column: index % gameEngine.state.gridSize) ? Color.blue : Color.clear, lineWidth: 2)
            )
    }

    private func imageForSymbol(_ symbol: String, in index: Int) -> some View {
        Image(symbol)
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .onDrag {
                if gameEngine.state.gameover {
                    return NSItemProvider()
                }

                let currentPlayerSymbol = gameEngine.state.currentPlayer == "X" ? "sun" : "moon"
                guard symbol == currentPlayerSymbol else {
                    return NSItemProvider() // Prevent dragging
                }
                
                guard gameEngine.canMoveSymbol(at: index) else {
                    return NSItemProvider()
                }
                draggedSymbol = symbol
                return NSItemProvider(object: symbol as NSString)
            }
    }




    private func handleDrop(providers: [NSItemProvider], to index: Int) -> Bool {
        guard let provider = providers.first else {
            print("No provider found for drop.")
            return false
        }
        
        provider.loadObject(ofClass: NSString.self) { (string, error) in
            if let error = error {
                print("Error loading item: \(error.localizedDescription)")
                return
            }
            
            guard let symbol = string as? String else {
                print("Error: Unable to retrieve symbol from dropped item.")
                return
            }
            
            DispatchQueue.main.async {
                print("Dropped symbol: \(symbol) to cell \(index)")
                if gameEngine.CellEmpty(for: index) {
                    // Find the source cell and clear it
                    for (cellIndex, value) in gameEngine.state.gridState {
                        if (symbol == "sun" && value == 1) || (symbol == "moon" && value == 0) {
                            gameEngine.state.gridState[cellIndex] = nil
                            break
                        }
                    }
                    
                    // Set the new cell
                    gameEngine.state.gridState[index] = (symbol == "sun") ? 1 : 0
                    gameEngine.SwitchPlayer()
                    
                    print("Cell updated: \(gameEngine.state.gridState[index])")
                } else {
                    print("Cell is not empty. Drop ignored.")
                }
            }
        }
        return true
    }

    
}
