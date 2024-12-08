import SwiftUI
import UniformTypeIdentifiers


struct ContentView: View {
    @StateObject private var gameEngine = GameEngine(gameState: GameState())
    @State private var draggedSymbol: String?
    @State private var isDropTargetActive = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var isPortrait: Bool {
        horizontalSizeClass == .compact
    }

    var body: some View {
        if isPortrait {
            drawPortraitUI().padding()
        }
        else {
            drawLandScapeUI().padding()
        }
        
    }
    
    // MARK: - Env drawing
        
    private func drawPortraitUI() -> some View {
        return VStack {
            Text("Tic-Tac-Toe").font(.title)
            HStack(spacing: 40) {
                Image("moon").resizable().frame(width: 60, height: 60)
                    .background(returnTurnColor(for: "O"))
                Image("sun").resizable().frame(width: 60, height: 60)
                    .background(returnTurnColor(for: "X"))
            }
            GameGrid(gameEngine: gameEngine)
            gridMoveButtons(gameEngine: gameEngine)
        }
    }
    
    private func drawLandScapeUI() -> some View {
        return HStack{
            VStack {
                GameGrid(gameEngine: gameEngine)
            }
            VStack(spacing: 10) {
                VStack {
                    Text("Tic-Tac-Toe").font(.title)
                    HStack(spacing: 40) {
                        Image("moon").resizable().frame(width: 60, height: 60)
                            .background(returnTurnColor(for: "O"))
                        Image("sun").resizable().frame(width: 60, height: 60)
                            .background(returnTurnColor(for: "X"))
                    }
                }
            }
            gridMoveButtons(gameEngine: gameEngine)
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
}

#Preview {
    ContentView()
}
