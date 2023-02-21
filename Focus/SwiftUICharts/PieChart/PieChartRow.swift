//
//  PieChartRow.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct PieChartRow : View {
    var valuedescribe : String?
    var data: [PieData]
    var backgroundColor: Color
    var accentColor: Color
    var slices: [PieSlice] {
        var tempSlices:[PieSlice] = []
        var lastEndDeg:Double = 0
        let value = GetValue()
        let maxValue = value.reduce(0, +)
        for slice in 0..<value.count{
            let normalized:Double = Double(value[slice])/Double(maxValue)
            let startDeg = lastEndDeg
            let endDeg = lastEndDeg + (normalized * 360)
            lastEndDeg = endDeg
            tempSlices.append(PieSlice(startDeg: startDeg, endDeg: endDeg, value: value[slice], normalizedValue: normalized,Color: data[slice].color))
        }
        return tempSlices
    }
    
    func GetValue()->[Double]{
        var datas : [Double] = []
        for i in data{
            datas.append(i.data)
        }
        return datas
    }
    
    @Binding var showValue: Bool
    @Binding var currentValue: PieData
    @Environment(\.PieChartshowLineMode) var showline : showlinemode
    @Environment(\.PieChartcirclescale) var scale : Double
    
    @State private var currentTouchedIndex = -1 {
        didSet {
            if oldValue != currentTouchedIndex {
                showValue = currentTouchedIndex != -1
                currentValue = showValue ? PieData(data: slices[currentTouchedIndex].value , color: slices[currentTouchedIndex].Color):PieData(data: 1)
            }
        }
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack{
                if showline == .always || showline == .incircle{
                    ForEach(0..<self.slices.count){ i in
                        PieChartCellAlways(valuedescribe:valuedescribe,currentvalue: data[i], rect: geometry.frame(in: .local), startDeg: self.slices[i].startDeg, endDeg: self.slices[i].endDeg, index: i, backgroundColor: self.backgroundColor, accentColor: self.accentColor)
                            .scaleEffect(self.currentTouchedIndex == i ? (scale + 0.1) : scale)
                            .animation(Animation.spring())
                    }
                }else if showline == .choicetime{
                    ForEach(0..<self.slices.count){ i in
                        PieChartCellChoice(valuedescribe:valuedescribe,currentTouchedIndex: $currentTouchedIndex, currentvalue: $currentValue, rect: geometry.frame(in: .local), startDeg: self.slices[i].startDeg, endDeg: self.slices[i].endDeg, index: i, backgroundColor: self.backgroundColor,accentColor: data[i].color)
                            .scaleEffect(self.currentTouchedIndex == i ? (scale + 0.1) : scale)
                            .animation(Animation.spring())
                    }
                }else{
                    ForEach(0..<self.slices.count){ i in
                        PieChartCellChoice(valuedescribe:valuedescribe,currentTouchedIndex: $currentTouchedIndex, currentvalue: $currentValue, rect: geometry.frame(in: .local), startDeg: self.slices[i].startDeg, endDeg: self.slices[i].endDeg, index: i, backgroundColor: self.backgroundColor,accentColor: data[i].color)
                            .scaleEffect(self.currentTouchedIndex == i ? (scale + 0.1) : scale)
                            .animation(Animation.spring())
                    }
                }
            }
            .gesture(DragGesture()
                .onChanged({ value in
                    let rect = geometry.frame(in: .local)
                    let isTouchInPie = isPointInCircle(point: value.location, circleRect: rect)
                    if isTouchInPie {
                        let touchDegree = degree(for: value.location, inCircleRect: rect)
                        self.currentTouchedIndex = self.slices.firstIndex(where: { $0.startDeg < touchDegree && $0.endDeg > touchDegree }) ?? -1
                    }else {
                        self.currentTouchedIndex = -1
                    }
                })
                .onEnded({ value in
                    self.currentTouchedIndex = -1
                }))
        }
    }
}

#if DEBUG
//struct PieChartRow_Previews : PreviewProvider {
//    static var previews: some View {
//        Group {
//            PieChartRow(data:[PieData(data: 10,color: .green),PieData(data: 80,color: .red),PieData(data: 70,color: .brown)], backgroundColor: Color(red: 252.0/255.0, green: 236.0/255.0, blue: 234.0/255.0), accentColor: Color(red: 225.0/255.0, green: 97.0/255.0, blue: 76.0/255.0), showValue: Binding.constant(false), currentValue: Binding.constant(0))
//                .frame(width: 100, height: 100)
////            PieChartRow(data:[0], backgroundColor: Color(red: 252.0/255.0, green: 236.0/255.0, blue: 234.0/255.0), accentColor: Color(red: 225.0/255.0, green: 97.0/255.0, blue: 76.0/255.0), showValue: Binding.constant(false), currentValue: Binding.constant(0))
////                .frame(width: 100, height: 100)
//        }
//    }
//}
#endif
