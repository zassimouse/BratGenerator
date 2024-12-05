//
//  KeyboardResponder.swift
//  BratGenerator
//
//  Created by Denis Haritonenko on 5.12.24.
//

import Combine
import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0
    private var cancellable: AnyCancellable?

    init() {
        cancellable = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification))
            .compactMap { notification -> CGFloat? in
                guard let userInfo = notification.userInfo else { return nil }
                let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                return endFrame?.height ?? 0
            }
            .assign(to: \.currentHeight, on: self)
    }
}
