//
//  test19.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/4.
//

import SwiftUI
import AVFoundation



struct test19: View {
    @EnvironmentObject var  model : Model
    @State var currentMusic = "小溪河流"
    @State var picker : [String] = ["小溪河流","大雨","雷雨","下雨","森林鸟叫","鸟叫","夏日蛙叫","海浪声"]
    @State var isplay : Bool = false
    @State var player : AVPlayer = AVPlayer(url: Bundle.main.url(forResource: "小溪河流", withExtension: "wav")!)
    @State var time : Timer?
    @State var rouatedegree  : Double = 0
    @State var show : Bool = false
    @State var showdetial : Bool = false
    
    var body: some View {
        VStack{
          
        }
        .SheetBottomView(isPresented: $show) {
            
        } content: {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 340)
                .foregroundColor(.green)
        }

    }
}

struct test19_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            test19()
                .previewInterfaceOrientation(.portraitUpsideDown)
                .environmentObject(Model())
        } else {
            // Fallback on earlier versions
        }
            
    }
}
