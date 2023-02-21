//
//  ViewExtension.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/28.
//

import SwiftUI

struct HasSignIn : EnvironmentKey{
    static var defaultValue:Bool = UserDefaults.standard.object(forKey: "HasSignIn") as! Bool
}

extension EnvironmentValues{
    var hasSignIn : Bool{
        get{self[HasSignIn.self]}
        set{self[HasSignIn.self] = newValue;UserDefaults.standard.set(newValue, forKey: "HasSignIn")}
    }
}
