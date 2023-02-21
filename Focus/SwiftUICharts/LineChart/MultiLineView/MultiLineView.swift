//
//  MultiLineView.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

struct MultiLineView: View {
    private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    public var data : MultiLineData
    @Environment(\.MultiLineChartTitle) private var title: String?
    @Environment(\.MultiLineChartLegend) private var legend: String?
    @Environment(\.MultiLinechartbackgroundColor) private var backgroundColor: Color
    @Environment(\.MultiLinechartaccentColor) private var accentColor: Color
    @Environment(\.MultiLinechartgradientColor) private var gradientColor: GradientColor
    @Environment(\.MultiLinecharttextColor) private var textColor: Color
    @Environment(\.MultiLinechartlegendTextColor) private var legendTextColor: Color
    @Environment(\.MultiLinechartdropShadowColor) private var dropShadowColor: Color
    @Environment(\.MultiLineChartDarkMode) private  var darkModeStyle: ChartStyle
    @Environment(\.MultiLinechartvaluespecifier) private var valueSpecifier: valuespecifier
    @Environment(\.MultiLinechartlegendSpecifier) private var legendSpecifier: valuespecifier
    @Environment(\.MultiLinechartheight) private var height: CGFloat
    @Environment(\.MultiLineshowcircle) private var showcricle: Bool
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @State private var showLegend = false
    @State private var dragLocation:CGPoint = .zero
    @State private var indicatorLocation:CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity:Double = 0
    @State private var currentDataNumber: Double = 0
    @State private var hideHorizontalLines: Bool = false
    @State private var width : CGFloat = 0
    private var showMode : [Color]{
        get{
            var mode = [Color]()
            for i in data.lineData{
                mode.append(i.lineColor.start)
            }
            mode.append(.clear)
            return mode
        }
    }
    @State private var choiceMode : [Int] = []
    
    var valuedescribe:String?
    public init(data:MultiLineData,valuedescribe:String? = "") {
        self.data = data
        self.valuedescribe = valuedescribe
    }
    
    public init(){
        self.data = MultiLineData( lineData: [
            oneLineData(data: [10,20,40,80,190,20,240,102], lineColor: GradientColor(start: .green, end: .green),lineLabel: "开心"),
            oneLineData(data: [102,90,12,40,120,90,80,30], lineColor: GradientColor(start: .red, end: .red),lineLabel: "不开心"),
            oneLineData(data:  [80,70,50,30,50,90,100], lineColor: GradientColor(start: .blue, end: .blue),lineLabel: "失望")
        ],Ylabel: [
            "01","02","03","04","05","06","07","08"
        ])
    }
    
    public var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width:width , height: self.idiom == .pad ? height + 200 : height + 140)
                .opacity(0)
            GeometryReader{ geometry in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width:width , height: self.idiom == .pad ? height + 200 : height + 140)
                    .foregroundColor(Color("white"))
                    .shadow(color: self.dropShadowColor, radius: 10, x: 0, y: 5)
                
                VStack(alignment: .leading, spacing: 8) {
                    Group{
                        if (self.title != nil){
                            HStack{
                                Text(self.title!)
                                    .font(.title)
                                    .bold().foregroundColor(Color("black"))
                                Spacer()
                                HStack{
                                    ForEach(Array(data.lineData.enumerated()),id:\.offset){ index,item in
                                                if showcricle{
                                                    HStack(spacing:3){
                                                        Button{
                                                            withAnimation {
                                                                if  self.choiceMode.contains(index){
                                                                    self.choiceMode.removeAll{$0 == index}
                                                                }else{
                                                                    self.choiceMode.append(index)
                                                                }
                                                            }
                                                        }label:{
                                                            Image(systemName: self.choiceMode.contains(index)  ? "checkmark.circle":"circle")
                                                        }
                                                        .foregroundColor(item.lineColor.start)
                                                }
                                                }
                                                Rectangle()
                                                    .foregroundColor(item.lineColor.start)
                                                    .frame(width:20,height: 2)
                                                if item.lineLabel != nil{
                                                    Text(item.lineLabel!)
                                                        .font(idiom == .pad ? .footnote : .system(size:3))
                                                        .foregroundColor(item.lineColor.start)
                                                }
                                            }
                                        
                                }
                            }
                            .padding(.horizontal)
                        }
                            HStack{
                                if (self.legend != nil){
                                    Text(self.legend!)
                                        .font(.callout)
                                        .foregroundColor(self.colorScheme == .dark ? self.darkModeStyle.legendTextColor : self.legendTextColor)
                                }
                            }
                    }.offset(x: 0, y:  idiom == .pad ? 20:0)
                    
                    ZStack{
                        GeometryReader{ reader in

                            if(self.showLegend){
                                MultiLegend(valuedescribe:valuedescribe,data:self.data,
                                       frame:.constant(reader.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines, specifier: legendSpecifier.rawValue)
                                    .transition(.opacity)
                                    .animation(.easeOut(duration: 1).delay(1),value:self.showLegend)
                            }
                                ZStack{
                                    ForEach(0..<self.data.lineData.count) { item in
                                        if self.choiceMode.contains(item) || self.choiceMode == []{
                                            Line(data: ChartData(points: self.data.lineData[item].data),
                                                 frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 30, height: reader.frame(in: .local).height + 25)),
                                                 touchLocation: self.$indicatorLocation,
                                                 showIndicator: self.$hideHorizontalLines,
                                                 minDataValue: .constant(nil),
                                                 maxDataValue: .constant(nil),
                                                 showBackground: false,
                                                 gradient: self.data.lineData[item].lineColor
                                            )
                                            .offset(x: valuedescribe != nil ? 50:30, y: 0)
                                            .onAppear(){
                                                self.showLegend = true
                                            }
                                        }
                                    }
                                }
                        }
                        .frame(width: geometry.frame(in: .local).size.width, height: height)
                        .offset(x: 0, y: idiom == .pad ? 40:-20)
                        .onDisappear {
                            self.showLegend = false
                        }
                        .onAppear {
                            withAnimation {
                                self.width = geometry.frame(in: .local).size.width
                            }
                        }
                    }
                    .scaleEffect(0.95)
                }
                .onAppear {
                    withAnimation {
                        self.choiceMode = [Int](0...self.data.lineData.count)
                    }
                }
            }
        }
        .padding()

    }
}

//struct MultiLineView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiLineView(data:
//                    MultiLineData( lineData: [
//                        oneLineData(data: [10,20,40,80,190,20,240,102], lineColor: GradientColor(start: .green, end: .green),lineLabel: "开心"),
//                        oneLineData(data: [102,90,12,40,120,90,80,30], lineColor: GradientColor(start: .red, end: .red),lineLabel: "不开心"),
//                        oneLineData(data:  [80,70,50,30,50,90,100], lineColor: GradientColor(start: .blue, end: .blue),lineLabel: "失望")
//                    ],Ylabel: [
//                        "01","02","03","04","05","06","07","08"
//                    ]),valuedescribe: "分钟")
//            .MultiLineViewShowYlabel(true)
//            .MultiLineViewSetTitle("h")
//            .MultlLineViewShowCircle(false)
//    }
//}

public struct MultiLineData : Identifiable{
    public var id = UUID()
    var lineData : [oneLineData]
    var Ylabel : [String]?
}

public struct oneLineData : Identifiable{
    public var id = UUID()
    var data : [Double]
    var lineColor : GradientColor
    var lineLabel : String?
}
