//
//  CommentTextView.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/5.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable {
    @Binding var text: String
    
    let beginEdittingOnAppear: Bool
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.backgroundColor = UIColor.systemGray4
        view.font = .systemFont(ofSize: 18)
        view.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        view.delegate = context.coordinator
        view.text = text
        
        return view
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if beginEdittingOnAppear,
           !context.coordinator.didBecomeFirstResponder,
           uiView.window != nil,
           !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }

    class Coordinator: NSObject, UITextViewDelegate {
        let parent: CommentTextView
        var didBecomeFirstResponder: Bool = false
        init(parent: CommentTextView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
    }
}

#Preview {
    CommentTextView(text: .constant(""), beginEdittingOnAppear: true)
}
