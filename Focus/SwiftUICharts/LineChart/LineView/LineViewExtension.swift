//
//  LineViewExtension.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI


extension View{
  
    func LineViewSetTitle(_ title : String)->some View{
        return self.environment(\.LineChartTitle, title)
    }
    func LineViewSetLegend(_ legend : String)->some View{
        return self.environment(\.LineChartLegend, legend)
    }
    func LineViewSetvaluespecifier(_ valuespecifier : valuespecifier)->some View{
        return self.environment(\.Linechartvaluespecifier, valuespecifier)
    }
    func LineViewSetlegendSpecifier(_ valuespecifier : valuespecifier)->some View{
        return self.environment(\.LinechartlegendSpecifier, valuespecifier)
    }
    
    func LineViewSetBackground(_ color:Color) -> some View{
        return self.environment(\.LinechartbackgroundColor, color)
    }
    
    func LineViewSetAccentColor(_ color:Color) -> some View{
        return self.environment(\.LinechartaccentColor, color)
    }
    
    func LineViewSetgradientColor(_ color:GradientColor) -> some View{
        return self.environment(\.LinechartgradientColor, color)
    }
    
    func LineViewSettextColor(_ color:Color) -> some View{
        return self.environment(\.LinecharttextColor, color)
    }
    func LineViewSetlegendTextColor(_ color:Color) -> some View{
        return self.environment(\.LinechartlegendTextColor, color)
    }
    
    func LineViewSetdropShadowColor(_ color:Color) -> some View{
        return self.environment(\.LinechartdropShadowColor, color)
    }
    
    func LineViewShowYlabel(_ bool : Bool)-> some View{
        return self.environment(\.LinechartShowYlabel, bool)
    }
    
    func LineViewSetHeight(_ height : CGFloat) ->some View{
        return self.environment(\.Linechartfromheight, height)
    }
}
