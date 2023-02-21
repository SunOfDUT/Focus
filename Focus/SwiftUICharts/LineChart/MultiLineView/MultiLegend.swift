//
//  MultiLegend.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

struct MultiLegend: View {
    var valuedescribe:String?
    var data : MultiLineData
    @Binding var frame: CGRect
    @Binding var hideHorizontalLines: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.LinechartShowYlabel) var showYlabel: Bool
    var specifier: String = "%.2f"
    let padding:CGFloat = 3
    var stepWidth: CGFloat {
        var maxcount = 0
        for i in data.lineData{
            if i.data.count > maxcount{
                maxcount = i.data.count
            }
        }
        if maxcount < 2 {
            return 0
        }
        return frame.size.width / CGFloat(maxcount)
    }
    var stepHeight: CGFloat {
        var min : Double = 0
        var max : Double = 0
        for i in data.lineData{
            guard !i.data.isEmpty else {break}
            if i.data.max()! > max{
                max = i.data.max()!
            }
            if i.data.min()! < min{
                min = i.data.min()!
            }
        }
        if min != max {
            if (min < 0){
                return (frame.size.height-padding) / CGFloat(max - min)
            }else{
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var min: CGFloat {
        var min : Double = 0
        for i in data.lineData{
            guard !i.data.isEmpty else {break}
            if i.data.min()! < min{
                min = i.data.min()!
            }
        }
        return CGFloat(min)
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            ForEach((0...4), id: \.self) { height in
                HStack(alignment: .center){
                    Text("\(self.getYLegendSafe(height: height), specifier: specifier)\(valuedescribe ?? "")").offset(x: 0, y: self.getYposition(height: height) )
                        .foregroundColor(Colors.LegendText)
                        .font(.caption)
                    self.line(atHeight: self.getYLegendSafe(height: height), width: self.frame.width)
                        .stroke(self.colorScheme == .dark ? Colors.LegendDarkColor : Colors.LegendColor, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5,height == 0 ? 0 : 10]))
                        .opacity((self.hideHorizontalLines && height != 0) ? 0 : 1)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 0.2))
                        .clipped()
                }
            }
            if showYlabel && data.Ylabel != nil{
                    HStack(spacing:0){
                        ForEach(data.Ylabel!){ item in
                            Spacer()
                            Text("\(item)")
                                .foregroundColor(Colors.LegendText)
                            Spacer()
                        }
                    }
                    .offset(x: 14, y: 35)
            }
        }
    }
    
    func getYLegendSafe(height:Int)->CGFloat{
        if let legend = getYLegend() {
            return CGFloat(legend[height])
        }
        return 0
    }
    
    func getYposition(height: Int)-> CGFloat {
        if let legend = getYLegend() {
            return (self.frame.height-((CGFloat(legend[height]) - min)*self.stepHeight))-(self.frame.height/2)
        }
        return 0
    }
    
    func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x:5, y: (atHeight-min)*stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: (atHeight-min)*stepHeight))
        return hLine
    }
    
    func getYLegend() -> [Double]? {
        var min : Double = 0
        var max : Double = 0
        
        for i in data.lineData{
            guard !i.data.isEmpty else {break}
            if i.data.max()! > max{
                max = i.data.max()!
            }
            if i.data.min()! < min{
                min = i.data.min()!
            }
        }
        let step = Double(max - min)/4
        return [min+step * 0, min+step * 1, min+step * 2, min+step * 3, min+step * 4]
    }
}
