# SwitchTabsBarKit

A lightweight, SwiftUI-style segmented tab bar with a capsule indicator.  
轻量级 SwiftUI 分段切换栏组件，支持链式 API、自定义主题与预置样式。

---

## ✨ Features

- ✅ SwiftUI 风格链式配置（点语法）
- ✅ 胶囊形底部指示线，宽度自动匹配文本
- ✅ 自定义字体、配色、间距、指示线
- ✅ 内置预置样式 `.presetDefault()`
- ✅ iOS 15 / macOS 12 起支持

---

## 📦 Installation

### Swift Package Manager





🚀 Usage
~~~
import SwiftUI
import SwitchTabsBarKit

struct ContentView: View {
    @State private var tab = 0

    var body: some View {
        VStack(spacing: 24) {
            // 使用预置样式
            SwitchTabsBar.presetDefault(
                titles: ["我的船队", "服务船队"],
                selection: $tab
            )

            // 自定义 SwiftUI 风格链式配置
            SwitchTabsBar(titles: ["主页", "设置"], selection: $tab)
                .accentColor(.blue)
                .inactiveColor(.gray.opacity(0.6))
                .tabFont(.system(size: 16, weight: .semibold))
                .tabSpacing(18)
                .tabPadding(vertical: 8, horizontal: 10)
                .indicator(height: 3, offsetY: 8)

            Text("当前选中：\(tab)")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}




🧩 Preview

#Preview {
    SwitchTabsBar.presetDefault(
        titles: ["我的船队", "服务船队"],
        selection: .constant(0)
    )
}

~~~


📱 Requirements
	•	iOS 15.0+
	•	macOS 12.0+
	•	Swift 5.9+




