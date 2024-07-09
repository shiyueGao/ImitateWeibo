//
//  HScrollViewController.swift
//  weiboDemo
//
//  Created by gaoshiyue on 2024/6/5.
//

import SwiftUI

struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    let pageWidth: CGFloat
    let contentSize: CGSize
    let content: Content
    
    @Binding var leftPercent: CGFloat
    
    init(pageWidth: CGFloat, contentSize: CGSize, leftPercent: Binding<CGFloat>, @ViewBuilder content: ()-> Content) {
        self.pageWidth = pageWidth
        self.contentSize = contentSize
        self.content = content()
        self._leftPercent = leftPercent // 要用 _属性
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    // 创建的时候 会调用一次，context 做赋值操作
    func makeUIViewController(context: Context) -> some UIViewController {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = context.coordinator
        context.coordinator.scrollView = scrollView
        
        
        let vc = UIViewController()
        vc.view.addSubview(scrollView)
        
        // 添加 swiftUI view 到 UIView
        let host = UIHostingController(rootView: content)
        vc.addChild(host)
        scrollView.addSubview(host.view)
        vc.didMove(toParent: host)
        context.coordinator.host = host
        
        return vc
    }
    
    // 更新会多次调用 可以获取 context
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let scrollView = context.coordinator.scrollView!
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
        context.coordinator.host.view.frame = CGRect(origin: .zero, size: contentSize)
    }
    
    // 在 context 中 Coordinator 属性， 可以放自定义属性
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var host: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation {
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }
        }
        
    }
}
