//
//  CircleColock.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/2.
//

import SwiftUI

struct PadCircleColock: View {
    @Binding var isPortrait : Bool
    @State var circleSize : CGFloat = 1
    var Circle : Color = Color("black")
    var water : Color = Color("black")
    @State var currenttime : String = ""
    @Binding var time : String
    @Binding var precent : Double
    var body: some View {
           ZStack{
            ZStack{
                VStack{
                    Spacer()
                    water.frame(height: circleSize * precent)
                }
                VStack(spacing:30){
                    Text(currenttime)
                    Text(time)
                }
                .font(.largeTitle)
                .foregroundColor(Color("white"))
            }
            .frame(width: circleSize, height: circleSize)
            .mask(SwiftUI.Circle().frame(width: circleSize, height: circleSize))
            
            SwiftUI.Circle()
                .trim(from: 0, to: 1)
                .stroke(style: StrokeStyle(lineWidth:15,lineCap: .square))
                .fill(.gray.opacity(0.2))
                .frame(width: circleSize, height: circleSize)
            
            SwiftUI.Circle()
                .trim(from:1-precent, to: 1)
                .stroke(style: StrokeStyle(lineWidth:15,lineCap: .square))
                .fill(Circle)
                .frame(width: circleSize, height: circleSize)
        }
           .onChange(of: precent) { newValue in
               currenttime = formatted3(time: Date())
           }
           .onAppear {
               if isPortrait{
                   self.circleSize = UIScreen.main.bounds.width / 2
               }else{
                   self.circleSize =  UIScreen.main.bounds.width / 3
               }
           }
           .onChange(of: isPortrait) { newValue in
               if isPortrait{
                   self.circleSize = UIScreen.main.bounds.width / 2
               }else{
                   self.circleSize =  UIScreen.main.bounds.width / 3
               }
           }
        
    }
}


struct PhoneCircleColock: View {
    @Binding var isPortrait : Bool
    @State var circleSize : CGFloat = 1
    var Circle : Color = .black
    var water : Color = .black
    @State var currenttime : String = ""
    @Binding var time : String
    @Binding var precent : Double
    var body: some View {
           ZStack{
            ZStack{
                VStack{
                    Spacer()
                    water.frame(height: circleSize * precent)
                }
                VStack(spacing:30){
                    Text(currenttime)
                    Text(time)
                }
                .foregroundColor(Color("white"))
                .font( isPortrait ?  .title:.title3)
            }
            .frame(width: circleSize, height: circleSize)
            .mask(SwiftUI.Circle().frame(width: circleSize, height: circleSize))
            
            SwiftUI.Circle()
                .trim(from: 0, to: 1)
                .stroke(style: StrokeStyle(lineWidth:15,lineCap: .square))
                .fill(Color("fadegray"))
                .frame(width: circleSize, height: circleSize)
            
            SwiftUI.Circle()
                   .trim(from: 1-precent, to:1)
                .stroke(style: StrokeStyle(lineWidth:15,lineCap: .square))
                .fill(Circle)
                .frame(width: circleSize, height: circleSize)
        
            }
           .onChange(of: precent) { newValue in
               currenttime = formatted3(time: Date())
           }
    }
}


//struct CircleColock_Previews: PreviewProvider {
//    static var previews: some View {
//        PadCircleColock(isPortrait: .constant(true))
//            .previewInterfaceOrientation(.portrait)
//    }
//}
