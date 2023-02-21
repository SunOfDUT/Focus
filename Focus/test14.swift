//
//  test14.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/30.
//

import SwiftUI

struct test14: View {
    @State private var isPortrait : Bool = UIDevice.current.orientation.isPortrait
    @State var isPresent : [Bool] = [false,false,false,false,false]

        var body: some View {
            ScrollView{
            VStack(alignment:.leading,spacing: 20){
                HStack{
                    Text("专注报告")
                        .font(.largeTitle)
                    Spacer()
                    Button{
                       
                    }label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    .font(.system(size: 25))
                }
                .padding(.top)
                .padding(.horizontal)
                .opacity(isPresent[0] ? 1:0)
                
                HStack{
                    Text("11:30-12:30")
                        .foregroundColor(Color("gray"))
                    Text("提前完成任务")
                         .font(.footnote)
                    Spacer()
                }
                .opacity(isPresent[0] ? 1:0)
                .padding(.horizontal)
              
                    ZStack{
                       
                        VStack(alignment:.leading,spacing: 20){
                            RoundChartView(data: [
                                RoundChartData(data: 90, label: "专注时长", color: Color("green")),
                                RoundChartData(data: 30, label: "放松时长", color: Color("pink"))
                            ],Title: "比例图")
                            .RoundCharttextColor(.white)
                            .RoundChartSetSize(70)
                            
                            HStack(alignment:.top){
                                VStack(alignment:.leading,spacing: 20){
                                    HStack{
                                        Text("暂停次数:")
                                        Text("2次")
                                    }
                                   
                                    HStack{
                                        Text("暂停时长:")
                                        Text("12分钟")
                                    }
                                  
                                }
                                .padding(.trailing)
                                
                                HStack{
                                        Text("分析:专注时长不够,暂停次数和时长比较多,放下手中的事情和心中的杂念,加油!")
                                    
                                }
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        .padding(.vertical)
                        .opacity(isPresent[1] ? 1:0)
                    }
                    .padding(.top)
              
                HStack{
                    Text("分析")
                        .bold()
                    Spacer()
                    Button{
                        
                    }label: {
                        Label("添加标签", systemImage: "plus")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                    
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.white)
                            .frame(width:250,height: 300)
                            .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
                            .padding(10)
                        
                        VStack(alignment:.leading,spacing: 20){
                            Text("专注时长:12分钟")
                            Text("最专注时段:11:30-12:30")
                            Text("分心时长:11分钟")
                            Text("分心时段:11:30-12:30")
                        }
                        .font(.system(size: 20))
                        .padding(20)
                    }
               
                        
                    PieChartView(data: [
                        PieData(data: 0.8,color:Color("green"),label: "预定完成时间"),
                        PieData(data: 0.2,color:Color("pink"),label: "实际完成时间")
                    ], valuedescribe: "")
                    .PieSetCharTitle("学习效率")
                    .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width / 1.8, height: 300))
                    
                   
                }
                .padding(.vertical)
                .padding(.horizontal)
            }
                  
                
                LineView()
                    .LineViewSetTitle("学习曲线")
            }
               
            }
            .foregroundColor(.black)
            .onAppear {
                withAnimation {
                    isPresent = Array(repeating: true, count: 5)
                }
            }
    }
}

struct test14_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            test14()
                .previewInterfaceOrientation(.portrait)
        } else {
            test14()
        }
    }
}
