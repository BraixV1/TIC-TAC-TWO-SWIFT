//
//  GridMoveButtons.swift
//  TIC-TAC-TOE-TWO
//
//  Created by Brajan Kukk on 08.12.2024.
//

import SwiftUI

struct gridMoveButtons: View {
    
    @ObservedObject var gameEngine: GameEngine
    
    
    
    var body: some View {
        
        VStack(spacing: 10) {
            // First Row
            HStack(spacing: 10) {
                GridMoveButton(title: "up left", action: {
                    gameEngine.moveActiveGrid(for: .topLeft)
                })
                GridMoveButton(title: "up", action: {
                    gameEngine.moveActiveGrid(for: .up)
                })
                GridMoveButton(title: "up right", action: {
                    gameEngine.moveActiveGrid(for: .topRight)
                })
            }
            
            HStack(spacing: 10) {
                GridMoveButton(title: "left", action: {
                    gameEngine.moveActiveGrid(for: .left)
                })
                
                Spacer()
                    .frame(width: 80, height: 80) // Placeholder for the missing middle button
                GridMoveButton(title: "right", action: {
                    gameEngine.moveActiveGrid(for: .right)
                })
            }
            
            // Third Row
            HStack(spacing: 10) {
                GridMoveButton(title: "down  left", action: {
                    gameEngine.moveActiveGrid(for: .bottomLeft)
                })
                GridMoveButton(title: "down", action: {
                    gameEngine.moveActiveGrid(for: .down)
                })
                GridMoveButton(title: "down right", action: {
                    gameEngine.moveActiveGrid(for: .bottomRight)
                })
            }
        }
        
    }
    
    
}
