//
//  CircleChartView.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/1.
//

import SwiftUI

public struct CircleChartView: View {
    public var precent : Double
    public var circleColor : Color
    public var circlesize : CGFloat
    public var lineWidth : CGFloat
    @State private var show : Bool = false
    public var body: some View {
        ZStack{
            Text("\(Int(precent*100))%")
            Circle()
                .trim(from: 0, to: show ? precent:0)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .fill(.angularGradient(colors:[circleColor], center: .center, startAngle: .degrees(0), endAngle: .degrees(60)))
                .frame(width:circlesize,height:circlesize)
        }
        .onAppear(perform: {
            withAnimation(.spring().delay(0.1)){
                show = true
            }
        })
        .padding(.leading)
    }
}

struct CircleChartView_Previews: PreviewProvider {
    static var previews: some View {
        CircleChartView(precent: 0.9, circleColor: .yellow,circlesize: 80,lineWidth: 6)
    }
}
