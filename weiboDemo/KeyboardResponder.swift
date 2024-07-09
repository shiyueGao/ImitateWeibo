//
//  KeyboardResponder.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/5.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var keyboradHeight: CGFloat = 0

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboradWillHiden(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboradWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        keyboradHeight = frame.height
    }

    @objc private func keyboradWillHiden(_ notification: Notification) {
        keyboradHeight = 0
    }
}
