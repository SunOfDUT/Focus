//
//  Key1.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/30.
//

import SwiftUI

enum valuespecifier : String{
    case twocount = "%.2f"
    case onecount = "%.1f"
    case nonecount = "%.0f"
}
enum Barshowmode{
    case never
    case always
    case ChoiceTime
}

struct BarChartTitleKey : EnvironmentKey{
    static var defaultValue: String = "Title"
}

struct BarChartSubTitleKey : EnvironmentKey{
    static var defaultValue : String? = "SubTitle"
}

struct BarChartStyleKey : EnvironmentKey{
    static var defaultValue : ChartStyle = Styles.barChartStyleOrangeLight
}

struct BarChartDarkModeStyleKey : EnvironmentKey{
    static var defaultValue : ChartStyle = Styles.barChartStyleOrangeDark
}

struct BarChartFormSizeKey : EnvironmentKey{
    static var defaultValue : CGSize = ChartForm.medium
}

struct BarChartIsBackgroundShadow : EnvironmentKey{
    static var defaultValue : Bool = true
}
struct BarChartcornerImage : EnvironmentKey{
    static var defaultValue : Image? = Image(systemName: "waveform.path.ecg")
}
struct BarChartValueSpecifier : EnvironmentKey{
    static var defaultValue : valuespecifier = .nonecount
}
struct BarChartanimatedToBack : EnvironmentKey{
    static var defaultValue : Bool = false
}
struct ShowTopNumber : EnvironmentKey{
    static var defaultValue : Bool = false
}

struct BarShowMode : EnvironmentKey{
    static var defaultValue: Barshowmode = .ChoiceTime
}

//struct BarSpacing : EnvironmentKey{
//    static var defaultValue : CGFloat = 0
//}
 
extension EnvironmentValues{
    var BarChartTitle : String{
        get{self[BarChartTitleKey.self]}
        set{self[BarChartTitleKey.self] = newValue}
    }
    var BarChartsubTitle : String?{
        get{self[BarChartSubTitleKey.self]}
        set{self[BarChartSubTitleKey.self] = newValue}
    }
    var BarChartstyle : ChartStyle{
        get{self[BarChartStyleKey.self]}
        set{self[BarChartStyleKey.self] = newValue}
    }
    var BarChartdarkmodestyle  : ChartStyle{
        get{self[BarChartDarkModeStyleKey.self]}
        set{self[BarChartDarkModeStyleKey.self] = newValue}
    }
    var BarChartformfize : CGSize{
        get{self[BarChartFormSizeKey.self]}
        set{self[BarChartFormSizeKey.self] = newValue}
    }
    var BarChartIsbackgroundshadow : Bool{
        get{self[BarChartIsBackgroundShadow.self]}
        set{self[BarChartIsBackgroundShadow.self] = newValue}
    }
    var BarChartcornerimage : Image?{
        get{self[BarChartcornerImage.self]}
        set{self[BarChartcornerImage.self] = newValue}
    }
    var BarChartvaluespecifier : valuespecifier{
        get{self[BarChartValueSpecifier.self]}
        set{self[BarChartValueSpecifier.self] = newValue}
    }
    var BarChartanimatedtoback : Bool{
        get{self[BarChartanimatedToBack.self]}
        set{self[BarChartanimatedToBack.self] = newValue}
    }
    var BarChartShowTopNumber: Bool{
        get{self[ShowTopNumber.self]}
        set{self[ShowTopNumber.self] = newValue}
    }
    var BarChartShowMode: Barshowmode{
        get{self[BarShowMode.self]}
        set{self[BarShowMode.self] = newValue}
    }
//    var Barspacing : CGFloat{
//        get{self[BarSpacing.self]}
//        set{self[BarSpacing.self] = newValue}
//    }
}
