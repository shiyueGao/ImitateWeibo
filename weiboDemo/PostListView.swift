//
//  PostListView.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

struct PostListView: View {
    let category :PostListCategory
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(userData.postList(for: category).list) { post in
                ZStack {
                    PostCell(post: post)
                        .background {
                            NavigationLink(destination: PostDetailView(post: post)) {
                                EmptyView()
                            }.opacity(0)
                        }
                }
                .listRowInsets(EdgeInsets())
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationView {
        PostListView(category: .recommend)
            .navigationTitle("Title")
            .navigationBarHidden(true)
            .environmentObject(UserData())
    }
}
