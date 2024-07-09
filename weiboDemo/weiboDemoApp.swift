//
//  weiboDemoApp.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/4.
//

import SwiftUI

@main
struct weiboDemoApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(leftPercent: 0).environmentObject(UserData())
        }
    }
}
