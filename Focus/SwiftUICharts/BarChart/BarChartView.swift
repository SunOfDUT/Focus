//
//  ChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartView : View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.BarChartTitle) var title : String
    @Environment(\.BarChartsubTitle) var subtitle : String?
//    @Environment(\.Chartstyle) var style : ChartStyle
    @Environment(\.BarChartdarkmodestyle) var darkModeStyle: ChartStyle
    @Environment(\.BarChartformfize)  var formSize:CGSize
    @Environment(\.BarChartIsbackgroundshadow) var dropShadow: Bool
    @Environment(\.BarChartcornerimage) var cornerImage: Image?
    @Environment(\.BarChartvaluespecifier) var valueSpecifier:valuespecifier
    @Environment(\.BarChartanimatedtoback) var animatedToBack: Bool
    @Environment(\.BarchartbackgroundColor) var backgroundColor: Color
    @Environment(\.BarchartaccentColor) var accentColor: Color
    @Environment(\.BarchartgradientColor) var gradientColor: GradientColor
    @Environment(\.BarcharttextColor) var textColor: Color
    @Environment(\.BarchartlegendTextColor) var legendTextColor: Color
    @Environment(\.BarchartdropShadowColor) var dropShadowColor: Color
    @Environment(\.BarChartShowMode) var showmode : Barshowmode
    
    var data: ChartData
    @State private var touchLocation: CGFloat = -1.0
    @State private var showValue: Bool = false
    @State private var showLabelValue: Bool = false
    @State var spacing : CGFloat = 0
    @State private var currentValue: Double = 0 {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
                HapticFeedback.playSelection()
            }
        }
    }
    
    public init(){
        self.data = TestData.values
    }
    
    var isFullWidth:Bool {
        return self.formSize == ChartForm.large
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(self.colorScheme == .dark ? self.darkModeStyle.backgroundColor : self.backgroundColor)
                .cornerRadius(20)
                .shadow(color: self.dropShadowColor , radius: self.dropShadow ? 8 : 0)
            VStack(alignment: .leading){
                HStack{
                    if(!showValue){
                        Text(self.title)
                            .font(.headline)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.textColor)
                    }else{
                        Text("\(self.currentValue, specifier: self.valueSpecifier.rawValue)分钟")
                            .font(.headline)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.textColor : self.textColor)
                    }
                    
                    if(self.formSize == ChartForm.large && self.subtitle != nil && !showValue) {
                        Text(self.subtitle!)
                            .font(.callout)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.accentColor : self.accentColor)
                            .transition(.opacity)
                            .animation(.easeOut, value: showValue)
                    }
                    Spacer()
                    self.cornerImage
                        .imageScale(.large)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.legendTextColor)
                }.padding()
                
                BarChartRow(data: data.points.map{$0.1},
                            accentColor: self.accentColor,
                            gradient: self.gradientColor,
                            touchLocation: self.$touchLocation, spacing: $spacing)
                
                if self.subtitle != nil  && self.formSize == ChartForm.medium && !self.showLabelValue{
                    Text(self.subtitle!)
                        .font(.headline)
                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.legendTextColor)
                        .padding()
                }else if (self.data.valuesGiven && self.getCurrentValue() != nil) && showmode == .ChoiceTime{
                        LabelView(datacount:data.points.count,arrowOffset: self.getArrowOffset(touchLocation: self.touchLocation),
                                  title: .constant(self.getCurrentValue()!.0))
                            .offset(x: self.getLabelViewOffset(touchLocation: self.touchLocation), y: -6)
                            .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.legendTextColor)
                }
                
            }
        }.frame(minWidth:self.formSize.width,
                maxWidth: self.isFullWidth ? .infinity : self.formSize.width,
                minHeight:self.formSize.height,
                maxHeight:self.formSize.height)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.touchLocation = value.location.x/self.formSize.width
                    self.showValue = true
                    self.currentValue = self.getCurrentValue()?.1 ?? 0
                    if(self.data.valuesGiven && self.formSize == ChartForm.medium) {
                        self.showLabelValue = true
                    }
                })
                .onEnded({ value in
                    if animatedToBack {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(Animation.easeOut(duration: 1)) {
                                self.showValue = false
                                self.showLabelValue = false
                                self.touchLocation = -1
                            }
                        }
                    } else {
                        self.showValue = false
                        self.showLabelValue = false
                        self.touchLocation = -1
                    }
                })
        )
            .gesture(TapGesture()
        )
    }
    
    func getArrowOffset(touchLocation:CGFloat) -> Binding<CGFloat> {
        let realLoc = (self.touchLocation * self.formSize.width) - 50
        if realLoc < 10 {
            return .constant(realLoc - 10)
        }else if realLoc > self.formSize.width-110 {
            return .constant((self.formSize.width-110 - realLoc) * -1)
        } else {
            return .constant(0)
        }
    }
    
    func getLabelViewOffset(touchLocation:CGFloat) -> CGFloat {
        return min(self.formSize.width-110,max(10,(self.touchLocation * self.formSize.width) - 50))
    }
    
    func getCurrentValue() -> (String,Double)? {
        guard self.data.points.count > 0 else { return nil}
        let index = max(0,min(self.data.points.count-1,Int(floor((self.touchLocation*self.formSize.width)/(self.formSize.width/CGFloat(self.data.points.count))))))
        return self.data.points[index]
    }
}

#if DEBUG
struct ChartView_Previews : PreviewProvider {
    static var previews: some View {
        BarChartView(data:TestData.values)
            .BarSetCharTitle("hello")
            .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width, height: 500))
            .BarShowChartTopNumber(true)
            .BarShowMode(.never)
    }
}
#endif
