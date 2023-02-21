//
//  ChartStyleKey.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI


struct BarChartbackgroundColor : EnvironmentKey{
    static var defaultValue: Color = Color("white")
}

struct BarChartaccentColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct BarChartgradientColor : EnvironmentKey{
    static var defaultValue: GradientColor = GradientColor(start: Color("black"), end: Color("black"))
}

struct BarCharttextColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct BarChartlegendTextColor : EnvironmentKey{
    static var defaultValue:Color = Color("black")
}

struct BarChartdropShadowColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct PieChartbackgroundColor : EnvironmentKey{
    static var defaultValue: Color = Color("white")
}

struct PieChartaccentColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct PieChartgradientColor : EnvironmentKey{
    static var defaultValue: GradientColor = GradientColor(start: Color("black"), end: Color("black"))
}

struct PieCharttextColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

struct PieChartlegendTextColor : EnvironmentKey{
    static var defaultValue:Color = Color("black")
}

struct PieChartdropShadowColor : EnvironmentKey{
    static var defaultValue: Color = Color("black")
}

extension EnvironmentValues{
    var BarchartbackgroundColor : Color{
        get{self[BarChartbackgroundColor.self]}
        set{self[BarChartbackgroundColor.self] = newValue}
    }
    var BarchartaccentColor : Color{
        get{self[BarChartaccentColor.self]}
        set{self[BarChartaccentColor.self] = newValue}
    }
    var BarchartgradientColor : GradientColor{
        get{self[BarChartgradientColor.self]}
        set{self[BarChartgradientColor.self] = newValue}
    }
    var BarchartlegendTextColor : Color{
        get{self[BarChartlegendTextColor.self]}
        set{self[BarChartlegendTextColor.self] = newValue}
    }
    var BarcharttextColor : Color{
        get{self[BarCharttextColor.self]}
        set{self[BarCharttextColor.self] = newValue}
    }
    var BarchartdropShadowColor : Color{
        get{self[BarChartdropShadowColor.self]}
        set{self[BarChartdropShadowColor.self] = newValue}
    }
    
    var PiechartbackgroundColor : Color{
        get{self[PieChartbackgroundColor.self]}
        set{self[PieChartbackgroundColor.self] = newValue}
    }
    var PiechartaccentColor : Color{
        get{self[PieChartaccentColor.self]}
        set{self[PieChartaccentColor.self] = newValue}
    }
    var PiechartgradientColor : GradientColor{
        get{self[PieChartgradientColor.self]}
        set{self[PieChartgradientColor.self] = newValue}
    }
    var PiechartlegendTextColor : Color{
        get{self[PieChartlegendTextColor.self]}
        set{self[PieChartlegendTextColor.self] = newValue}
    }
    var PiecharttextColor : Color{
        get{self[PieCharttextColor.self]}
        set{self[PieCharttextColor.self] = newValue}
    }
    var PiechartdropShadowColor : Color{
        get{self[PieChartdropShadowColor.self]}
        set{self[PieChartdropShadowColor.self] = newValue}
    }
}


