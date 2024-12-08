//
//  EntryView.swift
//  TIC-TAC-TOE-TWO
//
//  Created by Brajan Kukk on 23.11.2024.
//

import SwiftUI


struct EntryView : View {
    @State private var navigateToDetail = false
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    navigateToDetail = true
                }) {
                    Text("new game")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationDestination(isPresented: $navigateToDetail) {
                ContentView()
            }
        }
    }
}


#Preview {
    EntryView()
}
