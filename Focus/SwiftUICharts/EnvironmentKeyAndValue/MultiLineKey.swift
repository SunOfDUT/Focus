//
//  MultiLineExtension.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

struct MultiLineChartTitleKey : EnvironmentKey{
    static var defaultValue: String? = ""
}

struct MultiLineChartLegendKey : EnvironmentKey{
    static var defaultValue : String? = ""
}

struct MultiLineChartDarkModeStyleKey : EnvironmentKey{
    static var defaultValue : ChartStyle = Styles.lineChartStyleOne
}

struct MultiLineChartValueSpecifier : EnvironmentKey{
    static var defaultValue : valuespecifier = .nonecount
}
struct MultiLineChartLegendSpecifier : EnvironmentKey{
    static var defaultValue : valuespecifier = .nonecount
}

struct MultiLineShowYlabel : EnvironmentKey{
    static var defaultValue : Bool = true
}

struct MultiLineChartbackgroundColor : EnvironmentKey{
    static var defaultValue: Color = Color("white")
}

struct MultiLineChartaccentColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct MultiLineChartgradientColor : EnvironmentKey{
    static var defaultValue: GradientColor = GradientColor(start: Color("black"), end: Color("black"))
}

struct MultiLineCharttextColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct MultiLineChartlegendTextColor : EnvironmentKey{
    static var defaultValue:Color = Color("black")
}

struct MultiLineChartdropShadowColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct MultiLineChartHeight : EnvironmentKey{
    static var defaultValue: CGFloat = 240
}

struct MultiLineShowCircle : EnvironmentKey{
    static var defaultValue: Bool = true
}

extension EnvironmentValues{
    var MultiLineChartTitle : String?{
        get{self[MultiLineChartTitleKey.self]}
        set{self[MultiLineChartTitleKey.self] = newValue}
    }
    var MultiLineChartLegend : String?{
        get{self[MultiLineChartLegendKey.self]}
        set{self[MultiLineChartLegendKey.self] = newValue}
    }
    var MultiLineChartDarkMode : ChartStyle{
        get{self[MultiLineChartDarkModeStyleKey.self]}
        set{self[MultiLineChartDarkModeStyleKey.self] = newValue}
    }
    var MultiLinechartvaluespecifier : valuespecifier{
        get{self[MultiLineChartValueSpecifier.self]}
        set{self[MultiLineChartValueSpecifier.self] = newValue}
    }
    var MultiLinechartlegendSpecifier : valuespecifier{
        get{self[MultiLineChartLegendSpecifier.self]}
        set{self[MultiLineChartLegendSpecifier.self] = newValue}
    }
    var MultiLinechartShowYlabel : Bool{
        get{self[MultiLineShowYlabel.self]}
        set{self[MultiLineShowYlabel.self] = newValue}
    }
    
    var MultiLinechartbackgroundColor : Color{
        get{self[MultiLineChartbackgroundColor.self]}
        set{self[MultiLineChartbackgroundColor.self] = newValue}
    }
    var MultiLinechartaccentColor : Color{
        get{self[MultiLineChartaccentColor.self]}
        set{self[MultiLineChartaccentColor.self] = newValue}
    }
    var MultiLinechartgradientColor : GradientColor{
        get{self[MultiLineChartgradientColor.self]}
        set{self[MultiLineChartgradientColor.self] = newValue}
    }
    var MultiLinechartlegendTextColor : Color{
        get{self[MultiLineChartlegendTextColor.self]}
        set{self[MultiLineChartlegendTextColor.self] = newValue}
    }
    var MultiLinecharttextColor : Color{
        get{self[MultiLineCharttextColor.self]}
        set{self[MultiLineCharttextColor.self] = newValue}
    }
    var MultiLinechartdropShadowColor : Color{
        get{self[MultiLineChartdropShadowColor.self]}
        set{self[MultiLineChartdropShadowColor.self] = newValue}
    }
    var MultiLinechartheight : CGFloat{
        get{self[MultiLineChartHeight.self]}
        set{self[MultiLineChartHeight.self] = newValue}
    }
    var MultiLineshowcircle : Bool{
        get{self[MultiLineShowCircle.self]}
        set{self[MultiLineShowCircle.self] = newValue}
    }
}
