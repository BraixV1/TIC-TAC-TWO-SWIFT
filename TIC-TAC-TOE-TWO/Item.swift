//
//  Item.swift
//  TIC-TAC-TOE-TWO
//
//  Created by Brajan Kukk on 23.11.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
