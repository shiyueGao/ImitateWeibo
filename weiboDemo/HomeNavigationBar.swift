//
//  HomeNavigationBar.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

private let kLabelWidth: CGFloat = 60
private let kButtonHeight: CGFloat = 24

struct HomeNavigationBar: View {
  // 内部修改 如果想在代码中修改 属性 需要增加 State 修饰词
    
   // 外部修改 需要用 Binding 修饰词 外部 用$外部属性，进行数据绑定
   @Binding var leftPercent: CGFloat // 0 for lift, 1 for right

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Button(action: {
                print("Click camera button")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundStyle(.black)
            }

            Spacer()

            VStack(spacing: 3) {
                HStack(spacing: 0) {
                    Text("推荐")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        .opacity(Double(1 - self.leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 0
                            }
                        }

                    Spacer()

                    Text("推荐")
                        .bold()
                        .frame(width: kLabelWidth, height: kButtonHeight)
                        .padding(.top, 5)
                        .opacity(Double(0.5 + self.leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 1
                            }
                        }
                }
                .font(.system(size: 20))

                // geometry 获取到 当前 父控件宽高
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 2)
                        .foregroundStyle(.orange)
                        .frame(width: 30, height: 4)
                        .offset(x: self.leftPercent == 1 ? geometry.size.width - (kLabelWidth - 30) / 2 - 30 : (kLabelWidth - 30) / 2)
                }
                .frame(height: 6)
            }
            .frame(width: UIScreen.main.bounds.width * 0.5)

            Spacer()

            Button(action: {
                print("Click camera button")
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHeight, height: kButtonHeight)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundStyle(.orange)
            }
        }
    }
}

#Preview {
    HomeNavigationBar(leftPercent: .constant(0))
}
