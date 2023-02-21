//
//  Model.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI

class Model : ObservableObject{
    @Published var index : Int = 0
    @Published var myslect : SelectPage = .home
    @Published var select : SelectPage = .home
}

enum SelectPage {
    case home
    case analysis
}
