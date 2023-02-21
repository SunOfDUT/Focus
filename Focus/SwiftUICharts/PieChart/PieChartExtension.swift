//
//  PieChartExtension.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

extension View{
    // 设置title
    func PieSetCharTitle(_ title:String)->some View{
        return self.environment(\.PieChartTitle, title)
    }
    func PieSetChartLengend(_ legend:String)->some View{
        return self.environment(\.PieChartlegend, legend)
    }
    func PieSetChartbackgroundColor(_ color:Color)->some View{
        return self.environment(\.PiechartbackgroundColor, color)
    }
    func PieSetChartaccentColor(_ color:Color)->some View{
        return self.environment(\.PiechartaccentColor, color)
    }
    func PieSetChartdropShadowColor(_ color:Color)->some View{
        return self.environment(\.PiechartdropShadowColor, color)
    }
    func PieSetChartgradientColor(_ color:GradientColor)->some View{
        return self.environment(\.PiechartgradientColor, color)
    }
    func PieSetCharttextColor(_ color:Color)->some View{
        return self.environment(\.PiecharttextColor, color)
    }
    func PieSetChartlegendTextColor(_ color:Color)->some View{
        return self.environment(\.PiechartlegendTextColor, color)
    }
    func PieSetChartSize(_ Size:CGSize)->some View{
        return self.environment(\.PieChartformfize, Size)
    }
    func PieChartIsShowbackgroundShadow(_ bool:Bool)->some View{
        return self.environment(\.PieChartIsbackgroundshadow, bool)
    }
    func PieSetChartValueSpecifier(_ valuesspeci:valuespecifier)->some View{
        return self.environment(\.PieChartvaluespecifier, valuesspeci)
    }
    func PieShowLine(_ Mode:showlinemode)->some View{
        if Mode != .never{
            return
            self
                .environment(\.PieChartcirclescale, 0.7)
                .environment(\.PieChartshowLineMode, Mode)
        }
        
        return
            self
                .environment(\.PieChartcirclescale, 1.0)
                .environment(\.PieChartshowLineMode, Mode)
    }
    func PieSetInCircleTextColor(_ color:Color)->some View{
        return self.environment(\.PieChartIncircleColor, color)
    }
    func PieSetCircleScale(_ scale:Double)->some View{
        guard scale < 1.0 else {return self.PieSetCircleScale(1.0)}
        return self.environment(\.PieChartcirclescale, scale)
    }
}
//func SetCharTitle(_ title:String)->some View{
//    return self.environment(\.ChartTitle, title)
//}
//func SetChartSubTitle(_ subTitle:String)->some View{
//    return self.environment(\.ChartsubTitle, subTitle)
//}
//func SetChartbackgroundColor(_ color:Color)->some View{
//    return self.environment(\.chartbackgroundColor, color)
//}
//func SetChartaccentColor(_ color:Color)->some View{
//    return self.environment(\.chartaccentColor, color)
//}
//func SetChartdropShadowColor(_ color:Color)->some View{
//    return self.environment(\.chartdropShadowColor, color)
//}
//func SetChartgradientColor(_ color:GradientColor)->some View{
//    return self.environment(\.chartgradientColor, color)
//}
//func SetCharttextColor(_ color:Color)->some View{
//    return self.environment(\.charttextColor, color)
//}
//func SetChartlegendTextColor(_ color:Color)->some View{
//    return self.environment(\.chartlegendTextColor, color)
//}
//func SetChartSize(_ Size:CGSize)->some View{
//    return self.environment(\.Chartformfize, Size)
//}
//func ChartIsShowbackgroundShadow(_ bool:Bool)->some View{
//    return self.environment(\.ChartIsbackgroundshadow, bool)
//}
//func SetChartcornerImage(_ image:Image)->some View{
//    return self.environment(\.Chartcornerimage, image)
//}
//func SetChartValueSpecifier(_ valuesspeci:valuespecifier)->some View{
//    return self.environment(\.Chartvaluespecifier, valuesspeci)
//}
//func SetChartanimatedToBack(_ bool:Bool)->some View{
//    return self.environment(\.Chartanimatedtoback, bool)
//}
