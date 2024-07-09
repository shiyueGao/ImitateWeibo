//
//  HomeView.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 0 // 自己用或者传给自己的子view 使用修饰词  State
    var body: some View {
        NavigationView {
            GeometryReader { geomtry in
                HScrollViewController(pageWidth: geomtry.size.width, contentSize: CGSize(width: geomtry.size.width * 2, height: geomtry.size.height), leftPercent: self.$leftPercent) {
                    HStack(spacing: 0) {
                        PostListView(category: .recommend)
                            .frame(width: UIScreen.main.bounds.width)
                        PostListView(category: .hot)
                            .frame(width: UIScreen.main.bounds.width)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .toolbar(content: {
                HomeNavigationBar(leftPercent: $leftPercent) // 和当前 leftPercent 属性进行绑定
                    .frame(width: UIScreen.main.bounds.width)
            })
            .navigationTitle("首页")
            .navigationBarTitleDisplayMode(.inline)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    HomeView().environmentObject(UserData())
}
