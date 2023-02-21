//
//  RoundChartKey.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

struct RoundChartFormSize : EnvironmentKey{
    static var defaultValue: CGSize = CGSize(width: 0,height: 60)
}
struct RoundChartTextColor : EnvironmentKey{
    static var defaultValue: Color = Color("white")
}

extension EnvironmentValues{
    var RoundChartSize : CGSize{
        get{self[RoundChartFormSize.self]}
        set{self[RoundChartFormSize.self] = newValue}
        
    }
    var RoundCharttextColor : Color{
        get{self[RoundChartTextColor.self]}
        set{self[RoundChartTextColor.self] = newValue}
    }
}

extension View{
    func RoundChartSetSize(_ height:CGFloat)->some View{
        return self.environment(\.RoundChartSize, CGSize(width: 0, height: height))
    }
    func RoundCharttextColor(_ color : Color) -> some View{
        return self.environment(\.RoundCharttextColor, color)
    }
}
