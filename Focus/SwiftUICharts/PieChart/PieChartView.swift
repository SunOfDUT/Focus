//
//  PieChartView.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartView : View {
    public var data: [PieData]
    @Environment(\.PieChartTitle) var title : String
    @Environment(\.PieChartlegend) var legend: String?
//    @Environment(\.Chartstyle) var style : ChartStyle
    @Environment(\.PieChartformfize)  var formSize:CGSize
    @Environment(\.PieChartIsbackgroundshadow) var dropShadow: Bool
    @Environment(\.PieChartvaluespecifier) var valueSpecifier:valuespecifier
    @Environment(\.PiechartbackgroundColor) var backgroundColor: Color
    @Environment(\.PiechartaccentColor) var accentColor: Color
    @Environment(\.PiechartgradientColor) var gradientColor: GradientColor
    @Environment(\.PiecharttextColor) var textColor: Color
    @Environment(\.PiechartlegendTextColor) var legendTextColor: Color
    @Environment(\.PiechartdropShadowColor) var dropShadowColor: Color
    @Environment(\.PieChartshowLineMode) var showline : showlinemode
    
    public var valuedescribe : String?
    @State private var showValue = false
    @State private var currentValue: PieData = PieData(data: 0) {
        didSet{
            if(oldValue != self.currentValue && self.showValue) {
                HapticFeedback.playSelection()
            }
        }
    }
    
    public init(data: [PieData],valuedescribe : String? = ""){
        self.data = data
        self.valuedescribe = valuedescribe
    }

    public init(){
        self.data = [PieData(data: 10,color: .green,label: "休息"),PieData(data: 80,color: .red,label: "吃喝"),PieData(data: 70,color:.black,label: "玩乐"),PieData(data: 10,color: .blue,label: "yes")]
    }
    
    public var body: some View {
        ZStack{
            Rectangle()
                .fill(Color("white"))
                .cornerRadius(20)
                .shadow(color: self.dropShadowColor, radius: self.dropShadow ? 12 : 0)
            GeometryReader{ proxy in
                VStack(alignment: .leading){
                    HStack{
                        if(!showValue){
                            Text(self.title)
                                .font(.headline)
                                .foregroundColor(self.textColor)
                        }else{
                            Text("\(self.currentValue.data, specifier: self.valueSpecifier.rawValue)\(valuedescribe ?? "")")
                                .font(.headline)
                                .foregroundColor(self.textColor)
                        }
                        Spacer()
                        VStack{
                            Image(systemName: "chart.pie.fill")
                                .imageScale(.large)
                                .foregroundColor(self.legendTextColor)
                       
                        }
                      
                    }.padding()
                    ZStack{
                        PieChartRow(valuedescribe:valuedescribe,data: data, backgroundColor: self.backgroundColor, accentColor: self.accentColor, showValue: $showValue, currentValue: $currentValue)
                            .foregroundColor(self.accentColor).padding(self.legend != nil ? 0 : 12).offset(y:self.legend != nil ? 0 : -10)
                    }
                    .overlay(
                        VStack(alignment:.leading,spacing: 12){
                            ForEach(data){ item in
                                if item.color != nil {
                                    HStack{
                                        Circle()
                                            .foregroundColor(item.color)
                                            .frame(width: 20,height: 20)
                                        if item.label != nil{
                                            Text(item.label!)
                                                .foregroundColor(self.accentColor)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            Spacer()
                        }
                            .opacity(formSize.width > 350 && showline != .never  ? 1:0)
                        .padding()
                       
                    )
                    if(self.legend != nil) {
                        Text(self.legend!)
                            .font(.headline)
                            .foregroundColor(self.legendTextColor)
                            .padding()
                    }
                }
                .frame(width:proxy.frame(in: .local).width)
            }
          
        }.frame(width: self.formSize.width, height: self.formSize.height)
    }
}

#if DEBUG
struct PieChartView_Previews : PreviewProvider {
    static var previews: some View {
        PieChartView(data:[PieData(data: 10,color: .green,label: "休息"),PieData(data: 80,color: .red,label: "吃喝")],valuedescribe: "分钟")
            .PieSetChartSize(CGSize(width: 400, height: 400))
            .PieShowLine(.always)
            .PieSetInCircleTextColor(.white)
            .PieSetChartaccentColor(.gray)
    }
}
#endif
public struct PieData:Identifiable,Equatable{
    public var id = UUID()
    var data : Double
    var color : Color?
    var label : String?
}
