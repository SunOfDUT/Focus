//
//  BarChartExtension.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

extension View{
    // 设置title
    func BarSetCharTitle(_ title:String)->some View{
        return self.environment(\.BarChartTitle, title)
    }
    func BarSetChartSubTitle(_ subTitle:String)->some View{
        return self.environment(\.BarChartsubTitle, subTitle)
    }
    func BarSetChartbackgroundColor(_ color:Color)->some View{
        return self.environment(\.BarchartbackgroundColor, color)
    }
    func BarSetChartaccentColor(_ color:Color)->some View{
        return self.environment(\.BarchartaccentColor, color)
    }
    func BarSetChartdropShadowColor(_ color:Color)->some View{
        return self.environment(\.BarchartdropShadowColor, color)
    }
    func BarSetChartgradientColor(_ color:GradientColor)->some View{
        return self.environment(\.BarchartgradientColor, color)
    }
    func BarSetCharttextColor(_ color:Color)->some View{
        return self.environment(\.BarcharttextColor, color)
    }
    func BarSetChartlegendTextColor(_ color:Color)->some View{
        return self.environment(\.BarchartlegendTextColor, color)
    }
    func BarSetChartSize(_ Size:CGSize)->some View{
        return self.environment(\.BarChartformfize, Size)
    }
    func BarChartIsShowbackgroundShadow(_ bool:Bool)->some View{
        return self.environment(\.BarChartIsbackgroundshadow, bool)
    }
    func BarSetChartcornerImage(_ image:Image)->some View{
        return self.environment(\.BarChartcornerimage, image)
    }
    func BarSetChartValueSpecifier(_ valuesspeci:valuespecifier)->some View{
        return self.environment(\.BarChartvaluespecifier, valuesspeci)
    }
    func BarSetChartanimatedToBack(_ bool:Bool)->some View{
        return self.environment(\.BarChartanimatedtoback, bool)
    }
    
    func BarShowChartTopNumber(_ bool:Bool) -> some View{
        return self.environment(\.BarChartShowTopNumber, bool)
    }
    func BarShowMode(_ mode : Barshowmode)->some View{
        return self.environment(\.BarChartShowMode, mode)
    }
}

extension String:Identifiable{
    public var id : Int{
        return self.hashValue
    }
}

extension BarChartView{
    public init(data:ChartData){
        self.data = data
    }
}

