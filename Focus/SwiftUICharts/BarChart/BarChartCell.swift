//
//  ChartCell.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartCell : View {
    var data : Double
    var value: Double
    var index: Int = 0
    var width: Float
    var numberOfDataPoints: Int
    var cellWidth: Double {
        return Double(width)/(Double(numberOfDataPoints) * 1.5)
    }
    var accentColor: Color
    var gradient: GradientColor?
    @Environment(\.BarChartformfize) var formSize:CGSize
    @Environment(\.BarChartvaluespecifier) var valueSpecifier:valuespecifier
    @Environment(\.BarChartShowTopNumber) var showTopNuber:Bool
    @Environment(\.BarChartShowMode) var showmode : Barshowmode
    @State var scaleValue: Double = 0
    @Binding var touchLocation: CGFloat
    public var body: some View {
        ZStack(alignment:.bottom){
                RoundedRectangle(cornerRadius: 4)
                .fill(LinearGradient(gradient:gradient?.getGradient() ?? Gradient(colors: [.black,.white]),startPoint: .bottom, endPoint: .top))
                .frame(width: CGFloat(self.cellWidth))
                .scaleEffect(CGSize(width: 1, height: self.scaleValue), anchor: .bottom)
                .onAppear(){
                    self.scaleValue = self.value
                }
                .animation(Animation.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
            
            if showTopNuber && showmode == .ChoiceTime{
                VStack{
                    Text("\(data,specifier:valueSpecifier.rawValue)分钟")
                        .lineLimit(1)
                        .font(.system(size: 8))
                        .foregroundColor(gradient?.end)
                        .offset(y: (scaleValue) * (-10))
                    Color.clear.frame(width: 0, height: (scaleValue) * (formSize.height - 155))
                }
                .animation(.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
            }
            
            if showTopNuber && showmode == .always{
                VStack{
                    Text("\(data,specifier:valueSpecifier.rawValue)分钟")
                        .lineLimit(1)
                        .font(.system(size: 8))
                        .foregroundColor(gradient?.end)
                        .offset(y: (scaleValue) * (-40))
                    Color.clear.frame(width: 0, height: (formSize.height - 140) * scaleValue)
                }
                .animation(.spring().delay(self.touchLocation < 0 ?  Double(self.index) * 0.04 : 0))
            }
        }
    }
}

#if DEBUG
struct ChartCell_Previews : PreviewProvider {
    static var previews: some View {
        BarChartCell(data: 10, value: Double(0.75), width: 320, numberOfDataPoints: 12, accentColor: Colors.OrangeStart, gradient: nil, touchLocation: .constant(-1))
    }
}
#endif
