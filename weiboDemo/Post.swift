//
//  Post.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import Foundation
import SwiftUI

struct PostList: Codable {
    var list: [Post]
}

struct Post: Codable, Identifiable {
    let id: Int
    let avatar: String
    let vip: Bool
    let name: String
    let date: String
    
    var isFollowed: Bool
    
    let text: String
    let images: [String]
    
    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
}

extension Post {
    var avatrImage: Image {
        loadImage(name: avatar)
    }
    
    var commentCountText: String {
        if commentCount <= 0 {
            return "评论"
        }
        if commentCount < 1000 {
            return "\(commentCount)"
        }
        return String(format: "%.1fK", Double(commentCount) / 1000)
    }

    var likeCountText: String {
        if likeCount <= 0 {
            return "点赞"
        }
        if likeCount < 1000 {
            return "\(likeCount)"
        }

        return String(format: "%.1fK", Double(likeCount) / 1000)
    }
}

func loadPostListData(_ fileName: String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not find \(fileName) in main bundle")
    }

    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not find \(fileName) in main bundle")
    }

    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can not find \(fileName) in main bundle")
    }

    return list
}

func loadImage(name: String) -> Image {
    return Image(uiImage: UIImage(named: name)!)
}
