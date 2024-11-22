//
//  ContentView.swift
//  BratGenerator
//
//  Created by Denis Haritonenko on 22.11.24.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = "Brat"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
