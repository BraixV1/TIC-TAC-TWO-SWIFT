//
//  GridMoveButton.swift
//  TIC-TAC-TOE-TWO
//
//  Created by Brajan Kukk on 08.12.2024.
//

import SwiftUI

struct GridMoveButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action() // Call the closure
        }) {
            Text(title)
                .frame(width: 80, height: 80)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}


