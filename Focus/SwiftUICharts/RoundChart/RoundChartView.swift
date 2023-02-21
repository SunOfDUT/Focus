//
//  RounChartView.swift
//  someHealth
//
//  Created by 孙志雄 on 2022/8/31.
//

import SwiftUI

public struct RoundChartView: View {
    @Environment(\.RoundChartSize) private var formsize : CGSize
    @Environment(\.RoundCharttextColor) private var forecolor : Color
    public var data : [RoundChartData]
    public var Title : String?
    @State private var move : CGFloat = 0
    @State private var show : Bool = false
    func SumofData()->Double{
        var all : Double = 0
        for i in data{
            all += i.data
        }
        return all
    }
    
    func Getoffset(index:Int,frame:CGFloat)->CGFloat{
        var all : Double = 0
        for i in 0..<index{
            all += data[i].data
        }
        return (all / SumofData()) * frame
    }
    
   public var body: some View {
           VStack(alignment:.leading){
               HStack{
                   Text(Title ?? "")
                       .bold()
                   Spacer()
                   ForEach(data){ item in
                      Circle()
                           .foregroundColor(item.color)
                           .frame(width:20,height:20)
                       Text(item.label)
                           .font(.footnote)
                   }
               }
              
               .opacity(show ? 1:0)
             
               GeometryReader{ proxy in
                   HStack(spacing:0){
                       ForEach(Array(data.enumerated()),id:\.offset) { index,item in
                           RoundCardCell(index: index, item: item, frame: formsize.height, precent: item.data / SumofData(),width:proxy.frame(in: .local).width)
                       }
                   }
                   .frame(width: proxy.frame(in: .local).width)
                   .scaleEffect(CGSize(width:show ? 1:0, height: 1), anchor: .leading)
                   .mask(RoundedRectangle(cornerRadius: 20))
               }
               .frame(height:formsize.height)
           }
           .padding(.horizontal,10)
           .onAppear {
               withAnimation(.spring(response: 1,blendDuration: 0.08).delay(0.5)){
                   show = true
               }
           }
    }
}

struct RoundCardCell : View{
    var index : Int
    var item : RoundChartData
    var frame : CGFloat
    var precent : Double
    var width : CGFloat
    @Environment(\.RoundCharttextColor) var forecolor : Color
    var body : some View{
        if precent != 0{
            ZStack{
                Rectangle()
                    .foregroundColor(item.color)
                    .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
                if precent > 0.15{
                    Text("\(Int(precent * 100))%")
                        .foregroundColor(forecolor)
                }
            }
            .frame(width: precent > 0.1  ? width * precent : width * 0.1,height:frame)
        }else{
            ZStack{
                Rectangle()
                    .foregroundColor(item.color)
                    .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
                if precent > 0.15{
                    Text("\(Int(precent * 100))%")
                        .foregroundColor(forecolor)
                }
            }
            .frame(width: 0,height:frame)
        }

    }
}

public struct RoundChartData:Identifiable{
    public var id = UUID()
    var data : Double
    var label : String
    var color : Color
}

public struct RoundChartView_Previews: PreviewProvider {
    public static var previews: some View {
        RoundChartView(data: [
            RoundChartData(data: 22, label: "开心", color: .blue),
            RoundChartData(data: 0, label: "放松", color: .pink),
           ])
    }
}
