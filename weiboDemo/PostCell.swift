//
//  PostCell.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

struct PostCell: View {
    let post: Post

    var bindingPost: Post {
        userData.post(forId: post.id)!
    }

    @State var presentComment: Bool = false
    
    @EnvironmentObject var userData: UserData

    var body: some View {
        var post = bindingPost
        return VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 5) {
                post.avatrImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                    .overlay {
                        PostVipBadge(vip: post.vip)
                            .offset(x: 16, y: 16)
                    }

                VStack(alignment: .leading, spacing: 5) {
                    Text(post.name)
                        .font(Font.system(size: 16))
                        .foregroundStyle(Color(red: 242 / 255, green: 99 / 255, blue: 4 / 255))
                        .lineLimit(1)
                    Text(post.date)
                        .font(Font.system(size: 11))
                        .foregroundStyle(.gray)
                }
                .padding(.leading, 10)

                if !post.isFollowed {
                    Spacer()

                    Button {
                        post.isFollowed = true
                        self.userData.update(post)
                    } label: {
                        Text("关注")
                            .font(Font.system(size: 14))
                            .foregroundStyle(.orange)
                            .frame(width: 50, height: 26)
                            .overlay {
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(.orange, lineWidth: 1)
                            }
                    }
                }
            }

            Text(post.text)
                .font(.system(size: 17))

            if !post.images.isEmpty {
                PostImageCell(images: post.images, width: UIScreen.main.bounds.width - 30)
            }

            Divider()

            HStack(spacing: 0) {
                Spacer()
                PostCellToolbarButton(image: "message", text: post.commentCountText, color: .black) {
                    self.presentComment = true
                }
                .sheet(isPresented: $presentComment, content: {
                    CommentInputView(post: post).environmentObject(self.userData)
                })
                
                Spacer()
                
                PostCellToolbarButton(image: post.isLiked ? "heart.fill" : "heart", text: post.likeCountText, color: post.isLiked ? .red : .black) {
                    if post.isLiked {
                        post.isLiked = false
                        post.likeCount -= 1
                    } else {
                        post.isLiked = true
                        post.likeCount += 1
                    }
                    self.userData.update(post)
                }
                Spacer()
            }

            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundStyle(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
    }
}

#Preview {
    let userData = UserData()
    return PostCell(post: userData.recommendPostList.list[0]).environmentObject(userData)
}
