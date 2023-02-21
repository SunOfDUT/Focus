//
//  LineChartKey.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

struct LineChartTitleKey : EnvironmentKey{
    static var defaultValue: String? = ""
}

struct LineChartLegendKey : EnvironmentKey{
    static var defaultValue : String? = ""
}

struct LineChartDarkModeStyleKey : EnvironmentKey{
    static var defaultValue : ChartStyle = Styles.lineChartStyleOne
}

struct LineChartValueSpecifier : EnvironmentKey{
    static var defaultValue : valuespecifier = .nonecount
}
struct LineChartLegendSpecifier : EnvironmentKey{
    static var defaultValue : valuespecifier = .nonecount
}

struct LineShowYlabel : EnvironmentKey{
    static var defaultValue : Bool = true
}

struct LineChartbackgroundColor : EnvironmentKey{
    static var defaultValue: Color = Color("white")
}

struct LineChartaccentColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct LineChartgradientColor : EnvironmentKey{
    static var defaultValue: GradientColor = GradientColor(start: Color("black"), end: Color("black"))
}

struct LineCharttextColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct LineChartlegendTextColor : EnvironmentKey{
    static var defaultValue:Color = Color("black")
}

struct LineChartdropShadowColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}
struct LineChartFromheight : EnvironmentKey{
    static var defaultValue : CGFloat = 240
}

extension EnvironmentValues{
    var LineChartTitle : String?{
        get{self[LineChartTitleKey.self]}
        set{self[LineChartTitleKey.self] = newValue}
    }
    var LineChartLegend : String?{
        get{self[LineChartLegendKey.self]}
        set{self[LineChartLegendKey.self] = newValue}
    }
    var LineChartDarkMode : ChartStyle{
        get{self[LineChartDarkModeStyleKey.self]}
        set{self[LineChartDarkModeStyleKey.self] = newValue}
    }
    var Linechartvaluespecifier : valuespecifier{
        get{self[LineChartValueSpecifier.self]}
        set{self[LineChartValueSpecifier.self] = newValue}
    }
    var LinechartlegendSpecifier : valuespecifier{
        get{self[LineChartLegendSpecifier.self]}
        set{self[LineChartLegendSpecifier.self] = newValue}
    }
    var LinechartShowYlabel : Bool{
        get{self[LineShowYlabel.self]}
        set{self[LineShowYlabel.self] = newValue}
    }
    
    var LinechartbackgroundColor : Color{
        get{self[LineChartbackgroundColor.self]}
        set{self[LineChartbackgroundColor.self] = newValue}
    }
    var LinechartaccentColor : Color{
        get{self[LineChartaccentColor.self]}
        set{self[LineChartaccentColor.self] = newValue}
    }
    var LinechartgradientColor : GradientColor{
        get{self[LineChartgradientColor.self]}
        set{self[LineChartgradientColor.self] = newValue}
    }
    var LinechartlegendTextColor : Color{
        get{self[LineChartlegendTextColor.self]}
        set{self[LineChartlegendTextColor.self] = newValue}
    }
    var LinecharttextColor : Color{
        get{self[LineCharttextColor.self]}
        set{self[LineCharttextColor.self] = newValue}
    }
    var LinechartdropShadowColor : Color{
        get{self[LineChartdropShadowColor.self]}
        set{self[LineChartdropShadowColor.self] = newValue}
    }
    var Linechartfromheight : CGFloat{
        get{self[LineChartFromheight.self]}
        set{self[LineChartFromheight.self] = newValue}
    }
}
