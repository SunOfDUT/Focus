//
//  PieChart.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

enum showlinemode{
    case never
    case always
    case choicetime
    case incircle
}

struct PieChartTitleKey : EnvironmentKey{
    static var defaultValue: String = ""
}

struct PieChartlegendKey : EnvironmentKey{
    static var defaultValue : String? = ""
}

struct PieChartFormSizeKey : EnvironmentKey{
    static var defaultValue : CGSize = ChartForm.medium
}
struct PieChartIsBackgroundShadow : EnvironmentKey{
    static var defaultValue : Bool = true
}
struct PieChartValueSpecifier : EnvironmentKey{
    static var defaultValue : valuespecifier = .nonecount
}

struct PieChartShowLineMode : EnvironmentKey{
    static var defaultValue : showlinemode = .never
}

struct PieChartLineColor: EnvironmentKey{
    static var defaultValue : Color? = nil
}

struct PieChartInCircleTextColor : EnvironmentKey{
    static var defaultValue : Color = Color("white")
}

struct PieChartCircleScale : EnvironmentKey{
    static var defaultValue : Double = 1.0
}

extension EnvironmentValues{
    var PieChartTitle : String{
        get{self[PieChartTitleKey.self]}
        set{self[PieChartTitleKey.self] = newValue}
    }
    var PieChartlegend : String?{
        get{self[PieChartlegendKey.self]}
        set{self[PieChartlegendKey.self] = newValue}
    }
    var PieChartformfize : CGSize{
        get{self[PieChartFormSizeKey.self]}
        set{self[PieChartFormSizeKey.self] = newValue}
    }
    var PieChartIsbackgroundshadow : Bool{
        get{self[PieChartIsBackgroundShadow.self]}
        set{self[PieChartIsBackgroundShadow.self] = newValue}
    }
    var PieChartvaluespecifier : valuespecifier{
        get{self[PieChartValueSpecifier.self]}
        set{self[PieChartValueSpecifier.self] = newValue}
    }
    var PieChartshowLineMode : showlinemode{
        get{self[PieChartShowLineMode.self]}
        set{self[PieChartShowLineMode.self] = newValue}
    }
    var PieChartshowLineColor : Color?{
        get{self[PieChartLineColor.self]}
        set{self[PieChartLineColor.self] = newValue}
    }
    var PieChartIncircleColor : Color{
        get{self[PieChartInCircleTextColor.self]}
        set{self[PieChartInCircleTextColor.self] = newValue}
    }
    var PieChartcirclescale : Double{
        get{self[PieChartCircleScale.self]}
        set{self[PieChartCircleScale.self] = newValue}
    }
}
