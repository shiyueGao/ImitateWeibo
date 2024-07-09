//
//  UserData.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

import Combine

class UserData: ObservableObject {
    // 环境变量 （意思是如果 想在子时图修改数据， 变更所有使用数据的界面，需要用到 Published 修饰词）
    @Published var recommendPostList: PostList = loadPostListData("PostListData_recommend_1.json")
    @Published var hotPostList: PostList = loadPostListData("PostListData_hot_1.json")

    private var recommendPostDic: [Int: Int] = [:]
    private var hostPostDic: [Int: Int] = [:]

    init() {
        for i in 0 ..< recommendPostList.list.count {
            let post = recommendPostList.list[i]
            recommendPostDic[post.id] = i
        }

        for i in 0 ..< hotPostList.list.count {
            let post = hotPostList.list[i]
            hostPostDic[post.id] = i
        }
    }
}

enum PostListCategory {
    case recommend
    case hot
}

extension UserData {
    func postList(for category: PostListCategory) -> PostList {
        switch category {
        case .recommend:
            return recommendPostList
        case .hot:
            return hotPostList
        }
    }

    func post(forId id: Int) -> Post? {
        if let index = recommendPostDic[id] {
            return recommendPostList.list[index]
        }
        if let index = hostPostDic[id] {
            return hotPostList.list[index]
        }
        return nil
    }

    func update(_ post: Post) {
        if let index = recommendPostDic[post.id] {
            recommendPostList.list[index] = post
        }

        if let index = hostPostDic[post.id] {
            hotPostList.list[index] = post
        }
    }
}
