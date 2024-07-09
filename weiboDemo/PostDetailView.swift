//
//  PostDetailView.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    var body: some View {
        List {
            PostCell(post: post)
                .listRowInsets(EdgeInsets())
            
            ForEach(1...10, id: \.self) { i in
                Text("评论\(i)")
            }
        }
        .listStyle(.plain)
        .buttonStyle(PlainButtonStyle())
        .navigationTitle("详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let userData = UserData()
    return PostDetailView(post: userData.recommendPostList.list[0]).environmentObject(userData)
}
