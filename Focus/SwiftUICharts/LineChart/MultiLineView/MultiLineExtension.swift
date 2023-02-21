//
//  MultiLineExtension.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

extension View{
  
    func MultiLineViewSetTitle(_ title : String)->some View{
        return self.environment(\.MultiLineChartTitle, title)
    }
    func MultiLineViewSetLegend(_ legend : String)->some View{
        return self.environment(\.MultiLineChartLegend, legend)
    }
    func MultiLineViewSetvaluespecifier(_ valuespecifier : valuespecifier)->some View{
        return self.environment(\.MultiLinechartvaluespecifier, valuespecifier)
    }
    func MultiLineViewSetlegendSpecifier(_ valuespecifier : valuespecifier)->some View{
        return self.environment(\.MultiLinechartlegendSpecifier, valuespecifier)
    }
    
    func MultiLineViewSetBackground(_ color:Color) -> some View{
        return self.environment(\.MultiLinechartbackgroundColor, color)
    }
    
    func MultiLineViewSetAccentColor(_ color:Color) -> some View{
        return self.environment(\.MultiLinechartaccentColor, color)
    }
    
    func MultiLineViewSetgradientColor(_ color:GradientColor) -> some View{
        return self.environment(\.MultiLinechartgradientColor, color)
    }
    
    func MultiLineViewSettextColor(_ color:Color) -> some View{
        return self.environment(\.MultiLinecharttextColor, color)
    }
    func MultiLineViewSetlegendTextColor(_ color:Color) -> some View{
        return self.environment(\.MultiLinechartlegendTextColor, color)
    }
    
    func MultiLineViewSetdropShadowColor(_ color:Color) -> some View{
        return self.environment(\.MultiLinechartdropShadowColor, color)
    }
    
    func MultiLineViewShowYlabel(_ bool : Bool)-> some View{
        return self.environment(\.MultiLinechartShowYlabel, bool)
    }
    func MultlLineViewSetHeight(_ height:CGFloat)->some View{
        return self.environment(\.MultiLinechartheight, height)
    }
    func MultlLineViewShowCircle(_ bool:Bool)->some View{
        return self.environment(\.MultiLineshowcircle, bool)
    }
}
