// The Swift Programming Language
// https://docs.swift.org/swift-book

//
//  SwitchTabsBar.swift
//  ShipApp
//
//  Created by wangjie on 2025/11/12.
//  Copyright © 2025 zhang. All rights reserved.
//

import SwiftUI

/// 轻量级“按钮式分段切换栏”
/// - 特性：
///   - 任意数量的 segment
///   - 选中态加粗与主题色
///   - 文本等宽胶囊指示线（与文字同宽）
///   - 动画过渡
public struct SwitchTabsBar: View {
    public let titles: [String]
    @Binding public var selection: Int
    
    public var accentColor: Color
    public var inactiveColor: Color
    public var font: Font
    public var spacing: CGFloat
    public var verticalPadding: CGFloat
    public var horizontalPadding: CGFloat
    public var indicatorHeight: CGFloat
    public var indicatorOffsetY: CGFloat
    
    /// SwiftUI 风格的最小化初始化：只关心数据与状态绑定，其余通过点语法配置
    public init(
        titles: [String],
        selection: Binding<Int>
    ) {
        self.titles = titles
        self._selection = selection
        // 默认样式（可通过链式 API 覆盖）
        self.accentColor = .accentColor
        self.inactiveColor = .secondary
        self.font = .system(size: 16, weight: .medium)
        self.spacing = 12
        self.verticalPadding = 6
        self.horizontalPadding = 0
        self.indicatorHeight = 3
        self.indicatorOffsetY = 9
    }
    
    // MARK: - Fluent Modifiers (SwiftUI-style)
    /// 设置选中与指示线颜色
    public func accentColor(_ color: Color) -> Self {
        var v = self
        v.accentColor = color
        return v
    }
    
    /// 设置未选中颜色
    public func inactiveColor(_ color: Color) -> Self {
        var v = self
        v.inactiveColor = color
        return v
    }
    
    /// 设置字体
    public func tabFont(_ font: Font) -> Self {
        var v = self
        v.font = font
        return v
    }
    
    /// 设置 segment 间距
    public func tabSpacing(_ value: CGFloat) -> Self {
        var v = self
        v.spacing = value
        return v
    }
    
    /// 设置每个按钮的内边距
    public func tabPadding(vertical: CGFloat, horizontal: CGFloat) -> Self {
        var v = self
        v.verticalPadding = vertical
        v.horizontalPadding = horizontal
        return v
    }
    
    /// 设置底部胶囊指示线
    public func indicator(height: CGFloat, offsetY: CGFloat) -> Self {
        var v = self
        v.indicatorHeight = height
        v.indicatorOffsetY = offsetY
        return v
    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            
            ForEach(titles.indices, id: \.self) { idx in
                let isSelected = (idx == selection)
                Button {
                    selection = idx
                } label: {
                    Text(titles[idx])
                        .font(font)
                        .foregroundStyle(isSelected ? accentColor : inactiveColor)
                        // 关键：使用 overlay 让胶囊宽度 = 文本宽度
                        .overlay(alignment: .bottom) {
                            Capsule()
                                .fill(isSelected ? accentColor : .clear)
                                .frame(height: indicatorHeight)
                                .offset(y: indicatorOffsetY)
                                .padding(.horizontal, 5)
                        }
                        .padding(.vertical, verticalPadding)
                        .padding(.horizontal, horizontalPadding)
                        .contentShape(Rectangle()) // 扩大可点击区域
                }
                .buttonStyle(.plain)
            }
            
        }
        .animation(.easeInOut(duration: 0.2), value: selection)
    }
}

// MARK: - Preview (Mock)
#if DEBUG
struct SwitchTabsBar_Previews: PreviewProvider {
    struct Demo: View {
        @State private var selection = 0
        var body: some View {
            VStack {
                SwitchTabsBar(
                    titles: ["我的船队", "服务船队"],
                    selection: $selection
                )
                
                Text("当前选择：\(selection)")
                    .foregroundStyle(.secondary)
            }
            
        }
    }
    static var previews: some View {
        Demo()
            .previewDisplayName("SwitchTabsBar (Demo)")
    }
}
#endif


