//
//  ContentView.swift
//  BratGenerator
//
//  Created by Denis Haritonenko on 22.11.24.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = "brat"
    
    @State private var currentBackground: Color = .bratGreen
    @State private var currentScaleEffect: CGFloat = 1
    @State private var maxLines = 1
    
    @ObservedObject private var keyboardResponder = KeyboardResponder()

    
    enum Theme {
        case brat
        case deluxe
        case remix
    }
    
    @State private var currentTheme: Theme = .brat {
        didSet {
            switch currentTheme {
            case .brat:
                currentBackground = .bratGreen
                currentScaleEffect = 1
                maxLines = 1
            case .deluxe:
                currentBackground = .white
                currentScaleEffect = 1
                maxLines = 5
            case .remix:
                currentBackground = .bratGreen
                currentScaleEffect = -1
                maxLines = 6
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                resultView
                    .frame(
                        width: min(geometry.size.width, geometry.size.height),
                        height: max(
                            min(geometry.size.width, geometry.size.height) * 0.5,
                            geometry.size.height - keyboardResponder.currentHeight - 150
                        )
                    )
                Spacer()
                HStack {
                    TextField("Enter Text", text: $text)
                        .foregroundStyle(.black)
                        .autocapitalization(.none)
                    
                    Button {
                        currentTheme = .brat
                    } label: {
                        Circle()
                            .stroke(.black, lineWidth: 5)
                            .fill(.bratGreen)
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        currentTheme = .deluxe
                    } label: {
                        Circle()
                            .stroke(.black, lineWidth: 5)
                            .fill(.white)
                            .frame(width: 30, height: 30)
                    }
                    
                    Button {
                        currentTheme = .remix
                    } label: {
                        Circle()
                            .stroke(.black, lineWidth: 5)
                            .fill(.black)
                            .frame(width: 30, height: 30)
                    }
                                    
                    Button {
                        guard let image = ImageRenderer(content: ZStack {
                            Color(currentBackground)
                            resultView
                                .frame(width: 500, height: 500)
                        }
                        ).uiImage else {
                            return
                        }
                        
                        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

                    } label: {
                        Image(systemName: "square.and.arrow.up.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .tint(.black)
                    }
                }
                .padding()
                .background(.opacity(0.2))
                .clipShape(Capsule())
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background(currentBackground)
        }
    }
    
    var resultView: some View {
        Text(text)
            .scaleEffect(x: currentScaleEffect)
            .font(.system(size: 300))
            .lineLimit(maxLines)
            .minimumScaleFactor(0.01)
            .padding()
    }
}

#Preview {
    ContentView()
}
