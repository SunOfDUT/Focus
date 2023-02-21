//
//  PieChartCell.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct PieSlice: Identifiable {
    var id = UUID()
    var startDeg: Double
    var endDeg: Double
    var value: Double
    var normalizedValue: Double
    var Color : Color?
}

public struct PieChartCellChoice : View {
    @Environment(\.PieChartvaluespecifier) var valueSpecifier:valuespecifier
    @Environment(\.PieChartshowLineMode) var showline : showlinemode
    @Environment(\.PieChartshowLineColor) var showlineColor : Color?
    @Environment(\.PieChartformfize)  var formSize:CGSize
    @State private var show:Bool = false
    var valuedescribe : String?
    @Binding var currentTouchedIndex : Int
    @Binding var currentvalue : PieData
    var rect: CGRect
    var radius: CGFloat {
        return min(rect.width, rect.height)/2
    }
    var startDeg: Double
    var endDeg: Double
    var path: Path {
        var path = Path()
        path.addArc(center:rect.mid , radius:self.radius, startAngle: Angle(degrees: self.startDeg), endAngle: Angle(degrees: self.endDeg), clockwise: false)
        path.addLine(to:rect.mid)
        path.closeSubpath()
        return path
    }
    var path2 : Path{
        var path = Path()
        
        path.addRect(CGRect(x: rect.midX, y: rect.midY, width: radius + 40, height: 2))
        
        return path
    }
    var index: Int
    var backgroundColor:Color
    var accentColor:Color?
    func GenePath(in rect: CGRect) -> Path{
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: height))
        return path
    }
    
    func Arraypath(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99079*width, y: 0.5442*height))
        path.addCurve(to: CGPoint(x: 0.99079*width, y: 0.4558*height), control1: CGPoint(x: 0.99653*width, y: 0.51979*height), control2: CGPoint(x: 0.99653*width, y: 0.48021*height))
        path.addLine(to: CGPoint(x: 0.8972*width, y: 0.05806*height))
        path.addCurve(to: CGPoint(x: 0.87641*width, y: 0.05806*height), control1: CGPoint(x: 0.89146*width, y: 0.03365*height), control2: CGPoint(x: 0.88215*width, y: 0.03365*height))
        path.addCurve(to: CGPoint(x: 0.87641*width, y: 0.14645*height), control1: CGPoint(x: 0.87066*width, y: 0.08247*height), control2: CGPoint(x: 0.87066*width, y: 0.12204*height))
        path.addLine(to: CGPoint(x: 0.9596*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.87641*width, y: 0.85355*height))
        path.addCurve(to: CGPoint(x: 0.87641*width, y: 0.94194*height), control1: CGPoint(x: 0.87066*width, y: 0.87796*height), control2: CGPoint(x: 0.87066*width, y: 0.91753*height))
        path.addCurve(to: CGPoint(x: 0.8972*width, y: 0.94194*height), control1: CGPoint(x: 0.88215*width, y: 0.96635*height), control2: CGPoint(x: 0.89146*width, y: 0.96635*height))
        path.addLine(to: CGPoint(x: 0.99079*width, y: 0.5442*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.5625*height))
        path.addLine(to: CGPoint(x: 0.98039*width, y: 0.5625*height))
        path.addLine(to: CGPoint(x: 0.98039*width, y: 0.4375*height))
        path.addLine(to: CGPoint(x: 0, y: 0.4375*height))
        path.addLine(to: CGPoint(x: 0, y: 0.5625*height))
        path.closeSubpath()
        return path
    }
    
    public var body: some View {
        ZStack{
            if index == currentTouchedIndex && showline == .choicetime{
                path2
                    .rotation(.degrees(self.startDeg + (abs(self.endDeg - self.startDeg) / 2)))
                    .fill()
                    .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                    .overlay(path.stroke(.white, lineWidth: 2))
                    .scaleEffect(self.show ? 1 : 0)
                    .animation(.spring().delay(Double(self.index) * 0.04),value: self.index)
                
                
                if (endDeg - startDeg) > 30{
                    Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)\(valuedescribe ?? "")")
                        .font(formSize.height > 300 ? .system(size: 20):.footnote)
                        .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                        .offset(x:GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80),y: GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80))
    //                    .offset(x: self.show  ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80):0,y: self.show ?  GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius +  55):0)
                        .opacity(show ? 1:0)
                        .animation(.spring().delay(Double(self.index) * 0.2))
                }else{
                    Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)\(valuedescribe ?? "")")
                        .font(formSize.height > 300 ? .system(size: 20):.footnote)
                        .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                        .offset(x:GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 90),y: GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 40))
    //                    .offset(x: self.show  ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80):0,y: self.show ?  GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius +  55):0)
                        .opacity(show ? 1:0)
                        .animation(.spring().delay(Double(self.index) * 0.2))
                }
            }
            
            if showline == .always{
                path2
                    .rotation(.degrees(self.startDeg + (abs(self.endDeg - self.startDeg) / 2)))
                    .fill()
                    .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                    .overlay(path.stroke(.white, lineWidth: 2))
                    .scaleEffect(self.show ? 1 : 0)
                    .animation(.spring().delay(Double(self.index) * 0.04),value: self.index)
                
                if (endDeg - startDeg) > 30{
                    Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)\(valuedescribe ?? "")")
                        .font(formSize.height > 300 ? .system(size: 20):.footnote)
                        .foregroundColor(currentvalue.color ?? accentColor)
                        .offset(x:GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80),y: GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80))
    //                    .offset(x: self.show  ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80):0,y: self.show ?  GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius +  55):0)
                        .opacity(show ? 1:0)
                        .animation(.spring().delay(Double(self.index) * 0.2))
                }else{
                    Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)\(valuedescribe ?? "")")
                        .font(formSize.height > 300 ? .system(size: 20):.footnote)
                        .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                        .offset(x:GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 90),y: GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 40))
    //                    .offset(x: self.show  ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80):0,y: self.show ?  GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius +  55):0)
                        .opacity(show ? 1:0)
                        .animation(.spring().delay(Double(self.index) * 0.2))
                }
            }
            
             path
                .fill()
                .foregroundColor(self.accentColor)
                .overlay(path.stroke(self.backgroundColor, lineWidth: 2))
                .scaleEffect(self.show ? 1 : 0)
                .animation(Animation.spring().delay(Double(self.index) * 0.04))
                .onAppear(){
                    self.show = true
                }
        }
      
    }
}

public struct PieChartCellAlways : View {
    @Environment(\.PieChartvaluespecifier) var valueSpecifier:valuespecifier
    @Environment(\.PieChartshowLineMode) var showline : showlinemode
    @Environment(\.PieChartshowLineColor) var showlineColor : Color?
    @Environment(\.PieChartIncircleColor) var inCircleColor : Color
    @Environment(\.PieChartformfize)  var formSize:CGSize
    @State private var show : Bool = false
    var valuedescribe : String?
    @State var currentvalue : PieData
    var rect: CGRect
    var radius: CGFloat {
        return min(rect.width, rect.height)/2
    }
    var startDeg: Double
    var endDeg: Double
    var path: Path {
        var path = Path()
        path.addArc(center:rect.mid , radius:self.radius, startAngle: Angle(degrees: self.startDeg), endAngle: Angle(degrees: self.endDeg), clockwise: false)
        path.addLine(to:rect.mid)
        path.closeSubpath()
        return path
    }
    var path2 : Path{
        var path = Path()
        
        path.addRect(CGRect(x: rect.midX, y: rect.midY, width: radius + 40, height: 2))
        
        return path
    }
    var index: Int
    var backgroundColor:Color
    var accentColor:Color

    func GenePath(in rect: CGRect) -> Path{
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: width, y: height))
        return path
    }
    
    func Arraypath(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99079*width, y: 0.5442*height))
        path.addCurve(to: CGPoint(x: 0.99079*width, y: 0.4558*height), control1: CGPoint(x: 0.99653*width, y: 0.51979*height), control2: CGPoint(x: 0.99653*width, y: 0.48021*height))
        path.addLine(to: CGPoint(x: 0.8972*width, y: 0.05806*height))
        path.addCurve(to: CGPoint(x: 0.87641*width, y: 0.05806*height), control1: CGPoint(x: 0.89146*width, y: 0.03365*height), control2: CGPoint(x: 0.88215*width, y: 0.03365*height))
        path.addCurve(to: CGPoint(x: 0.87641*width, y: 0.14645*height), control1: CGPoint(x: 0.87066*width, y: 0.08247*height), control2: CGPoint(x: 0.87066*width, y: 0.12204*height))
        path.addLine(to: CGPoint(x: 0.9596*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.87641*width, y: 0.85355*height))
        path.addCurve(to: CGPoint(x: 0.87641*width, y: 0.94194*height), control1: CGPoint(x: 0.87066*width, y: 0.87796*height), control2: CGPoint(x: 0.87066*width, y: 0.91753*height))
        path.addCurve(to: CGPoint(x: 0.8972*width, y: 0.94194*height), control1: CGPoint(x: 0.88215*width, y: 0.96635*height), control2: CGPoint(x: 0.89146*width, y: 0.96635*height))
        path.addLine(to: CGPoint(x: 0.99079*width, y: 0.5442*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.5625*height))
        path.addLine(to: CGPoint(x: 0.98039*width, y: 0.5625*height))
        path.addLine(to: CGPoint(x: 0.98039*width, y: 0.4375*height))
        path.addLine(to: CGPoint(x: 0, y: 0.4375*height))
        path.addLine(to: CGPoint(x: 0, y: 0.5625*height))
        path.closeSubpath()
        return path
    }
    
    public var body: some View {
        ZStack{
            if showline == .always{
                path2
                    .rotation(.degrees(self.startDeg + (abs(self.endDeg - self.startDeg) / 2)))
                    .fill()
                    .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                    .overlay(path.stroke(.white, lineWidth: 2))
                    .scaleEffect(self.show ? 1 : 0)
                    .animation(.spring().delay(Double(self.index) * 0.04),value: self.index)
                
                if (endDeg - startDeg) > 30{
                    Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)\(valuedescribe ?? "")")
                        .font(formSize.height > 300 ? .system(size: 20):.footnote)
                        .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                        .offset(x:GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80),y: GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80))
    //                    .offset(x: self.show  ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80):0,y: self.show ?  GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius +  55):0)
                        .opacity(show ? 1:0)
                        .animation(.spring().delay(Double(self.index) * 0.2))
                }else{
                    Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)\(valuedescribe ?? "")")
                        .font(formSize.height > 300 ? .system(size: 20):.footnote)
                        .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                        .offset(x:GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 90),y: GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 40))
    //                    .offset(x: self.show  ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80):0,y: self.show ?  GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius +  55):0)
                        .opacity(show ? 1:0)
                        .animation(.spring().delay(Double(self.index) * 0.2))
                }
            }
            
 
            
        if showline == .incircle && (endDeg - startDeg) < 30{
                    path2
                        .rotation(.degrees(self.startDeg + (abs(self.endDeg - self.startDeg) / 2)))
                        .fill()
                        .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                        .overlay(path.stroke(.white, lineWidth: 2))
                        .scaleEffect(self.show ? 1 : 0)
                        .animation(.spring().delay(Double(self.index) * 0.04),value: self.index)
                
                Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)\(valuedescribe ?? "")")
                    .font(formSize.height > 300 ? .system(size: 20):.footnote)
                    .foregroundColor(showlineColor != nil ? showlineColor:accentColor)
                    .offset(x:GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 90),y: GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 40))
//                    .offset(x: self.show  ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius + 80):0,y: self.show ?  GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius +  55):0)
                    .opacity(show ? 1:0)
                    .animation(.spring().delay(Double(self.index) * 0.06))
            }
        }
        
        path
            .fill()
            .foregroundColor(currentvalue.color)
            .overlay(path.stroke(self.backgroundColor, lineWidth: 2))
            .scaleEffect(self.show ? 1 : 0)
            .animation(.spring().delay(Double(self.index) * 0.04))
            .onAppear(){
                self.show = true
            }
      
        if showline == .incircle && (endDeg - startDeg) > 30{
            Text("\(currentvalue.data,specifier:valueSpecifier.rawValue)分钟")
                .font(formSize.height > 300 ? .system(size: 20):.footnote)
                .foregroundColor(inCircleColor)
                .offset(x:self.show ? GetCos(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius / 2):0,y: self.show  ? GetSin(degree:self.startDeg + abs(self.endDeg - self.startDeg) / 2) * (radius / 2) : 0)
                .animation(.spring().delay(Double(self.index) * 0.04))
        }
    }
}

extension CGRect {
    var mid: CGPoint {
        return CGPoint(x:self.midX, y: self.midY)
    }
}

#if DEBUG
//struct PieChartCell_Previews : PreviewProvider {
//    static var previews: some View {
//        GeometryReader { geometry in
//            PieChartCell(currentTouchedIndex: .constant(0), rect: geometry.frame(in: .local),startDeg: 0.0,endDeg: 120.0, index: 0, backgroundColor: Color(red: 252.0/255.0, green: 236.0/255.0, blue: 234.0/255.0), accentColor: Color(red: 225.0/255.0, green: 97.0/255.0, blue: 76.0/255.0))
//            }.frame(width:100, height:100)
//
//    }
//}
#endif
