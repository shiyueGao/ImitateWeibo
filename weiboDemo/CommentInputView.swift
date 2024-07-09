//
//  CommentInputView.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/5.
//

import SwiftUI

struct CommentInputView: View {
    let post: Post

    @State private var text: String = ""
    @State private var showEmotyTextHUD: Bool = false

    // 模态 退出页面 系统自代环境变量 还有其他属性
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var userData: UserData

    @ObservedObject private var keyboardResponder = KeyboardResponder()

    var body: some View {
        VStack(spacing: 0) {
            CommentTextView(text: $text, beginEdittingOnAppear: true)

            HStack(spacing: 0) {
                Button(action: {
                    print("Cancel")
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("取消").padding()
                })

                Spacer()

                Button(action: {
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        self.showEmotyTextHUD = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.showEmotyTextHUD = false
                        }
                        return
                    }
                    print("\(self.text)")
                    var post = self.post
                    post.commentCount += 1
                    userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                    print("Send")
                }, label: {
                    Text("发送").padding()
                })
            }
            .font(.system(size: 18))
            .foregroundStyle(.black)
        }
        .overlay {
            Text("评论不能为空")
                .scaleEffect(showEmotyTextHUD ? 1 : 0.5)
                .opacity(showEmotyTextHUD ? 1 : 0)
                .animation(.easeInOut, value: 1)
        }
    }
}

#Preview {
    CommentInputView(post: UserData().recommendPostList.list[0])
}
