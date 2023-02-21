//
//  LineView.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct LineView: View {
    private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    @ObservedObject var data: ChartData
    @Environment(\.LineChartTitle) var title: String?
    @Environment(\.LineChartLegend)  var legend: String?
    @Environment(\.LinechartbackgroundColor) var backgroundColor: Color
    @Environment(\.LinechartaccentColor) var accentColor: Color
    @Environment(\.LinechartgradientColor) var gradientColor: GradientColor
    @Environment(\.LinecharttextColor) var textColor: Color
    @Environment(\.LinechartlegendTextColor) var legendTextColor: Color
    @Environment(\.LinechartdropShadowColor) var dropShadowColor: Color
    @Environment(\.LineChartDarkMode)  var darkModeStyle: ChartStyle
    @Environment(\.Linechartvaluespecifier) var valueSpecifier: valuespecifier
    @Environment(\.LinechartlegendSpecifier) var legendSpecifier: valuespecifier
    @Environment(\.Linechartfromheight) var Linechartfromheight : CGFloat
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var showLegend = false
    @State private var dragLocation:CGPoint = .zero
    @State private var indicatorLocation:CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity:Double = 0
    @State private var currentDataNumber: Double = 0
    @State private var hideHorizontalLines: Bool = false
    @State var formwidth : CGFloat = 0
    @State private var maxwidth : CGFloat = 0
    var valuedescribe:String?
    
    public init(data:ChartData,valuedescribe:String? = "") {
        self.data = data
        self.valuedescribe = valuedescribe
    }
    public init(){
        self.data = ChartData(values: [("28",120),("29",140),("30",160),("31",180),("1",20),("2",60),("3",80),("4",240),("5",10)])
    }
    
      
    
    public var body: some View {
        ZStack(alignment:.center){
            if idiom == .phone{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: formwidth, height: self.idiom == .pad ? Linechartfromheight + 200 : Linechartfromheight + 140)
                    .opacity(0)
            }else{
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: formwidth, height: self.idiom == .pad ? Linechartfromheight + 200 : Linechartfromheight + 140)
                    .opacity(0)
            }
            
            GeometryReader{ geometry in
                if idiom == .phone{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: formwidth, height: self.idiom == .pad ? Linechartfromheight + 200 : Linechartfromheight + 140)
                        .foregroundColor(Color("white"))
                        .shadow(color: self.dropShadowColor, radius: 10, x: 0, y: 5)
                }else{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: formwidth, height: self.idiom == .pad ? Linechartfromheight + 200 : Linechartfromheight + 140)
                        .foregroundColor(Color("white"))
                        .shadow(color: self.dropShadowColor, radius: 10, x: 0, y: 5)
                }
                VStack(alignment: .leading, spacing: 8) {
                    Group{
                        if (self.title ?? "" != "") {
                            Text(self.title!)
                                .font(.title)
                                .bold().foregroundColor(Color("black"))
                        }
                        if (self.legend ?? "" != ""){
                            Text(self.legend!)
                                .font(.callout)
                                .bold()
                                .foregroundColor(Color("black"))
                        }
                    }.offset(x: 10, y: 20)
                    
                    ZStack(alignment:.center){
                        GeometryReader{ reader in
                            if(self.showLegend){
                                Legend(valuedescribe:valuedescribe,data: self.data,
                                       frame:.constant(reader.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines, specifier: legendSpecifier.rawValue)
                                    .transition(.opacity)
                                    .animation(.easeOut(duration: 0.1).delay(0.1))
                            }
                            Line(data: self.data,
                                 frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - 30, height: reader.frame(in: .local).height + 25)),
                                 touchLocation: self.$indicatorLocation,
                                 showIndicator: self.$hideHorizontalLines,
                                 minDataValue: .constant(nil),
                                 maxDataValue: .constant(nil),
                                 showBackground: false,
                                 gradient: self.gradientColor
                            )
                            .offset(x: valuedescribe != nil ? 50:30, y: 0)
                            .onAppear(){
                                self.showLegend = true
                            }
                            .onDisappear(){
                                self.showLegend = false
                            }
                        }
                        .frame(width: geometry.frame(in: .local).size.width , height: 240)
                        .offset(x: 0, y: 40 )
                        .scaleEffect(0.95)
                        MagnifierRect(currentNumber: self.$currentDataNumber, valueSpecifier: self.valueSpecifier.rawValue)
                            .opacity(self.opacity)
                            .offset(x: self.dragLocation.x - geometry.frame(in: .local).size.width/2, y: 36)
                    }
                    .onAppear(perform: {
                        withAnimation {
                            formwidth =  geometry.frame(in: .local).size.width
                        }
                    })
                    .onChange(of: geometry.frame(in: .local).size.width, perform: { newValue in
                        withAnimation {
                            formwidth =  newValue
                        }
                    })
                    .gesture(DragGesture()
                    .onChanged({ value in
                        self.dragLocation = value.location
                        self.indicatorLocation = CGPoint(x: max(value.location.x-30,0), y: 32)
                        self.opacity = 1
                        self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width-30, height: 240)
                        self.hideHorizontalLines = true
                    })
                        .onEnded({ value in
                            self.opacity = 0
                            self.hideHorizontalLines = false
                        })
                    )
                    Spacer()
                }
            }
        }
        .padding()

    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(floor((toPoint.x-15)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentDataNumber = points[index]
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

//struct LineView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LineView(data:ChartData(values: [("28",120),("29",140),("30",160),("31",180),("1",20),("2",60),("3",80),("4",240),("5",10)]), valuedescribe: "分钟")
//                .LineViewShowYlabel(true)
//        }
//    }
//}

