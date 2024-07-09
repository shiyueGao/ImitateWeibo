//
//  PostCellToolbarButton.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

struct PostCellToolbarButton: View {
    let image: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                Text(text)
                    .font(.system(size: 15))
            }
            .foregroundStyle(color)
        }
    }
}

#Preview {
    PostCellToolbarButton(image: "heart", text: "点赞", color: .red) {
        print("点赞")
    }
}
