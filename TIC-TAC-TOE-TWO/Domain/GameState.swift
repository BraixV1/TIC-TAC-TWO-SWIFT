import Foundation

class GameState: ObservableObject {
    var id: Int
    var dt: Int64
    var currentRound: Int
    let totalRoundsBeforeGrid: Int
    let gridSize: Int
    var activeGridX: Int
    var activeGridY: Int
    var knotsCount: Int
    var crossesCount: Int
    var isActiveGridPhase: Bool
    var currentPlayer: String
    var gridState: [Int: Int?]

    var gameover: Bool

    init(
        id: Int = 0,
        dt: Int64 = Int64(Date().timeIntervalSince1970 * 1000),
        currentRound: Int = 0,
        totalRoundsBeforeGrid: Int = 6,
        gridSize: Int = 5,
        activeGridX: Int = 1,
        activeGridY: Int = 1,
        knotsCount: Int = 0,
        crossesCount: Int = 0,
        isActiveGridPhase: Bool = false,
        currentPlayer: String = "X",
        gameover: Bool = false
    ) {
        self.id = id
        self.dt = dt
        self.currentRound = currentRound
        self.totalRoundsBeforeGrid = totalRoundsBeforeGrid
        self.gridSize = gridSize
        self.activeGridX = activeGridX
        self.activeGridY = activeGridY
        self.knotsCount = knotsCount
        self.crossesCount = crossesCount
        self.isActiveGridPhase = isActiveGridPhase
        self.currentPlayer = currentPlayer
        self.gridState = (0..<gridSize * gridSize).reduce(into: [:]) { $0[$1] = nil }
        self.gameover = gameover
    }
}
