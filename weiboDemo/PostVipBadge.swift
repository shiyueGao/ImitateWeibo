//
//  PostVipBadge.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

struct PostVipBadge: View {
    let vip: Bool
    var body: some View {
        Group {
            if vip {
                Text("v")
                    .bold()
                    .font(.system(size: 11))
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.yellow)
                    .background(Color.red)
                    .clipShape(.circle)
                    .overlay {
                        RoundedRectangle(cornerRadius: 7.5)
                            .stroke(.white, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    }
            }
        }
    }
}

#Preview {
    PostVipBadge(vip: true)
}
