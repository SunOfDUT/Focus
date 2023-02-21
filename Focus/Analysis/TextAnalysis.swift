//
//  TextAnalysis.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/29.
//

import SwiftUI


struct TextAnalysis: View {
//  @Binding var selectDate : Date
    @Binding var isPortrait : Bool
    @State private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    @ObservedObject var MyAnalysiser : Analysiser
    @EnvironmentObject var MyAllData : AllData
    @EnvironmentObject var mylistdata : ToDoListData
    @Binding var MainMode : String
//    @State var alltime :  [Double] = [1]
//    @State var focustime : [timeDate] = []
//    @State var resttime : [timeDate] = []
//    @State var anslysisData : AnysisData = AnysisData(count: 1,AdvanceAllTime: 1,ForceStop: 1)
//    @State var DateCount : Int = 0
    @State private  var show : Bool = false
    @State private var show2 : Bool = false
    var body: some View {
        Group{
        if idiom == .phone{
           VStack{
                if GetValue(time:MyAnalysiser.focustime).count != 0 && GetValue(time:MyAnalysiser.focustime).count != 0{
                    if isPortrait{
                        PhoneViewPro
                            .opacity(show ? 1:0)
                    }else{
                        Text("不支持横屏查看")
                    }
                }else{
                    if isPortrait{
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("green"))
                                .frame(height:70)
                                .scaleEffect(CGSize(width:show ? 1:0 , height: 1), anchor: .leading)
                                .padding(.horizontal,10)
                                
                            Text("今天什么都没有留下哦")
                                .foregroundColor(Color("white"))
                        }
                    }else{
                        Text("不支持横屏查看")
                    }
                }
            }
        }else{
            ScrollView(showsIndicators: false){
                VStack(alignment:.center){
                    if GetValue(time:MyAnalysiser.focustime).count != 0 && GetValue(time:MyAnalysiser.focustime).count != 0{
                        RoundChartView(data: [
                            RoundChartData(data: SumTime(time: GetValue(time: MyAnalysiser.focustime)), label: "专注时长", color: Color("green")),
                            RoundChartData(data: SumTime(time: GetValue(time: MyAnalysiser.resttime)), label: "放松时长", color: Color("pink"))
                        ],Title: "学习比例图")
                        .RoundCharttextColor(Color("white"))
                        .RoundChartSetSize(60)
                        .padding(.horizontal,idiom == .pad ? 10:0)
                        
                        
                        PadView
                        
                        
                   
                        
                    }else{
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("green"))
                                .frame(height:70)
                                .scaleEffect(CGSize(width:show ? 1:0 , height: 1), anchor: .leading)
                                .padding(.horizontal,10)
                                
                            Text("今天什么都没有留下哦")
                                .foregroundColor(Color("white"))
                        }
                    }
            }
            }
        }
        }
        .onAppear {
            withAnimation(.easeIn.delay(0.5)){
                show = true
            }
            withAnimation(.easeIn.delay(0.7)){
                show2 = true
            }
        }
    }
    
   
    
    var PadView : some View{
            VStack(alignment:.leading,spacing: 20){
                HStack(alignment:.top){
                    VStack{
                        ZStack{
                            if #available(iOS 15.0, *) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                                    .shadow(color: show2 ? Color("black"):.clear, radius:  10, x: 0, y: 5)
                            } else {
                                // Fallback on earlier versions
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .blur(radius: 2)
                                    .shadow(color: show2 ? Color("black"):.clear, radius:  10, x: 0, y: 5)
                            }
                                
                            HStack(spacing:18){
                                VStack{
                                    Text("学习效率")
                                    CircleChartView(precent: (SumTime(time: MyAnalysiser.alltime) > MyAnalysiser.anslysisData.AdvanceAllTime ? MyAnalysiser.anslysisData.AdvanceAllTime/SumTime(time: MyAnalysiser.alltime) : SumTime(time: MyAnalysiser.alltime) / MyAnalysiser.anslysisData.AdvanceAllTime )
                                                    ,circleColor: Color("yellow")
                                                    ,circlesize: 80
                                                    ,lineWidth: 10)
                                }
                                    VStack{
                                        Text("任务完成度")
                                        CircleChartView(precent: Double((1 - MyAnalysiser.anslysisData.ForceStop/MyAnalysiser.anslysisData.count))
                                                        ,circleColor: Color("yellow")
                                                        ,circlesize: 80
                                                        ,lineWidth: 10)
                                    }
                                
                            }
                        }
//                        .opacity(show ? 1:0)
                       
//                        ZStack{
//                            if #available(iOS 15.0, *) {
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(.ultraThinMaterial)
//                                    .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//                            } else {
//                                // Fallback on earlier versions
//                                RoundedRectangle(cornerRadius: 20)
//                                    .foregroundColor(.white)
//                                    .blur(radius: 2)
//                                    .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//
//                            }
//
//                            Text("相关建议")
//                        }
//                        .opacity(show ? 1:0)
                    }
                    .frame(width:300)
                    
                    VStack{
                        ZStack{
                    
                            if #available(iOS 15.0, *) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                                    .shadow(color: show2 ? Color("black"):.clear, radius:  10, x: 0, y: 5)
                            } else {
                                // Fallback on earlier versions
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.white)
                                    .blur(radius: 2)
                                    .shadow(color: show ? Color("black"):.clear, radius:  10, x: 0, y: 5)
                            }
                           
                            HStack{
                                VStack(alignment:.leading,spacing: 15){
                                    ZStack(alignment: .leading){
//
                                        VStack(alignment:.leading,spacing: 20){
                                            
                                                HStack{
                                                    Text("总时长:")
                                                    Text("\(GetTime2(time: SumTime(time: MyAnalysiser.alltime)))")
                                                        
                                                }
                                            
                                            HStack{
                                                Text("专注总时长:")
                                                Text("\(GetTime2(time: SumTime(time: GetValue(time: MyAnalysiser.focustime))))")
                                                    
                                            }
                                            
                                            HStack{
                                                Text("放松总时长:")
                                                Text("\(GetTime2(time: SumTime(time: GetValue(time: MyAnalysiser.resttime))))")
                                                    
                                            }
                                            
                                    
                                            VStack(alignment:.leading,spacing: 15){
                                                if self.MainMode != "单日报告分析"{
                                                    HStack{
                                                        Text("专注天数:")
                                                        Text("\(MyAnalysiser.DateCount)天")
                                                    }
                                                }
                                                
                                                HStack{
                                                    Text("专注任务:")
                                                    Text("\(MyAnalysiser.anslysisData.count)个")
                                                }
                                                
                                                if self.MainMode == "单日报告分析"{
                                                    HStack{
                                                        Text("专注时间最长:")
                                                        Text("\(formatted(time:GetMyMaxTime(time: MyAnalysiser.focustime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.focustime).1))")
                                                    }
                                                    
                                                    HStack{
                                                        Text("放松时间最长:")
                                                        Text("\(formatted(time:GetMyMaxTime(time: MyAnalysiser.resttime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.resttime).1))")
                                                    }
                                                }else{
                                                    HStack{
                                                        Text("专注时间最长:")
                                                        Text("\(formatted3(time:GetMyMaxTime(time: MyAnalysiser.focustime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.focustime).1))")
                                                    }
                                                    
                                                    HStack{
                                                        Text("放松时间最长:")
                                                        Text("\(formatted3(time:GetMyMaxTime(time: MyAnalysiser.resttime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.resttime).1))")
                                                    }
                                                }
                                                
                                            }
                                        }
                                        .padding()
                                    }
                                }
                                .padding()
                                
                                Divider()
                                
                               
                                VStack(alignment:.leading){
                                    HStack{
                                        Text("标签")
                                            .font(.footnote)
                                        Spacer()
                                    }
                                   
                                    
                                    
                                    if MyAnalysiser.anslysisData.tag == []{
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Label("什么都没有留下哦", systemImage: "doc.plaintext")
                                                .font(.footnote)
                                                .foregroundColor(Color("gray"))
                                            Spacer()
                                        }
                                        Spacer()
                                    }else{
                                        ScrollView(showsIndicators: false){
                                            VStack(alignment:.leading){
                                                ForEach(MyAnalysiser.anslysisData.tag){ item in
                                                    Text(item)
                                                    Divider()
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding()
                                Spacer()
                            }
                        }
//                        .opacity(show ? 1:0)
                    }
                }
                .frame(height: 300)
                .padding()
                .opacity(show ? 1:0)
                
                Group{
                if MyAnalysiser.RestDistribute.value != [] &&  MyAnalysiser.FocusDistribute.value != []{
                    switch MainMode{
                        case "单日报告分析":
                            VStack{
                                PieChartView(data: [
                                    PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 60, color: Color("green"), label: "专注"),
                                    PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 60, color: Color("pink"), label: "放松")
                                ], valuedescribe: "分钟")
                                .PieSetCharTitle("学习效率")
                                .PieSetChartSize(CGSize(width:UIScreen.main.bounds.width - 50, height: 450))
                                .PieShowLine(.choicetime)
                                
                                 LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)), valuedescribe: "分钟")
                                        .LineViewSetHeight(250)
                                        .LineViewSetTitle("休息分析")
                                        .LineViewSetgradientColor(GradientColor(start: Color("pink"), end:Color("pink")))
                                       
                                 LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)), valuedescribe: "分钟")
                                        .LineViewSetHeight(250)
                                        .LineViewSetTitle("专注分析")
                                        .LineViewSetgradientColor(GradientColor(start: Color("green"), end:Color("green")))
                                
                            }
                           
                        default:
                            if MyAnalysiser.FocusDistribute.value.count > 2{
                                 Group{
                                         MultiLineView(data: MultiLineData(
                                             lineData: [
                                                 //第一条线是我们的每一天的放松时间
                                                 oneLineData(data: MyAnalysiser.RestDistribute.value.map{$0 / 60}, lineColor: GradientColor(start: Color("pink"), end:Color("pink")),lineLabel: "每日放松时长"),
                                                 oneLineData(data: MyAnalysiser.FocusDistribute.value.map{$0 / 60}, lineColor: GradientColor(start: Color("green"), end: Color("green")),lineLabel: "每日专注日常"),
                                                 oneLineData(data: MyAnalysiser.TaskCount.value, lineColor: GradientColor(start: Color("yellow"), end: Color("yellow")),lineLabel: "每日任务总数"),
                                                 oneLineData(data: MyAnalysiser.RestCount.value, lineColor: GradientColor(start: .red, end: .red),lineLabel: "每日休息次数总数")
                                             ]
                                             ,Ylabel: MyAnalysiser.RestDistribute.day)
                                             ,valuedescribe: "分钟")
                                         .MultiLineViewSetTitle("整体分析图")
                                     .MultiLineViewSetlegendTextColor(Color("black"))
                                     .MultiLineViewSetBackground(Color("white"))
                                     .MultiLineViewSetdropShadowColor(Color("black"))
                                     .MultlLineViewSetHeight(UIScreen.main.bounds.width / 3)
                                 }
                                 .padding(.top,30)
                                
                                VStack{
                                    BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)))
                                        .BarSetCharTitle("休息统计图")
                                        .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                                        .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
                                    BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)))
                                        .BarSetCharTitle("专注统计图")
                                        .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                                        .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
                                }
                            }
                             VStack{
                                     HStack(spacing:20){
                                         // 学习总时长 / 学习放松时长
                                         // 放松次数 任务次数 强制停止次数
                                         PieChartView(data: [
                                             PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 3600, color: Color("green"), label: "专注"),
                                             PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 3600, color: Color("pink"), label: "放松")
                                         ], valuedescribe: "小时")
                                         .PieSetCharTitle("学习效率")
                                             .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width / 2 - 30, height: 400))
                                             .PieShowLine(.choicetime)
                                           
                                         PieChartView(data: [
                                             PieData(data: Double(MyAnalysiser.anslysisData.count), color: Color("yellow"), label: "任务"),
                                             PieData(data: Double(MyAnalysiser.anslysisData.ForceStop), color: Color("pink"), label: "强制制止"),
                                             PieData(data: Double(MyAnalysiser.RestDistribute.value.count), color: Color("green"), label: "暂停")
                                         ], valuedescribe: "次")
                                         .PieSetCharTitle("学习完成度")
                                         .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width / 2 - 30, height: 400))
                                         .PieShowLine(.choicetime)
                                     }
                             }
                                     
                        }
                    }
                }
                .opacity(show ? 1:0)
                    Color.clear.frame(height: 60)
                }
            
                .foregroundColor(Color("black"))
                .padding()
            }
           
    
    
    var PhoneViewPro : some View{
        VStack(spacing:0){
                RoundChartView(data: [
                    RoundChartData(data: SumTime(time: GetValue(time: MyAnalysiser.focustime)), label: "专注时长", color: Color("green")),
                    RoundChartData(data: SumTime(time: GetValue(time: MyAnalysiser.resttime)), label: "放松时长", color: Color("pink"))
                ],Title: "学习比例图")
                .RoundCharttextColor(Color("white"))
                .RoundChartSetSize(60)
                .padding(.horizontal,idiom == .pad ? 10:0)
                
                TabView{
                    phonetext
                        .padding()
                        .tag(0)
                    
                    phoneTag
                        .padding()
                        .tag(1)
                }
                .frame(height:230)
                .tabViewStyle(.page)
                
               
                TabView{
                    PieChartView(data: [
                        PieData(data: SumTime(time: MyAnalysiser.alltime) / 60,color: Color("pink"),label: "预定完成时长"),
                        PieData(data: MyAnalysiser.anslysisData.AdvanceAllTime / 60, color: Color("green"), label: "实际完成时长")
                    ],valuedescribe: "分钟")
                    .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 40, height: 350))
                    .PieSetCharTitle("学习效率")
                    .PieShowLine(.never)
                    .padding()
                    .tag(0)
                    
                    PieChartView(data: [
                        PieData(data: Double(MyAnalysiser.anslysisData.ForceStop),color: Color("pink"),label: "强制停止"),
                        PieData(data: Double(MyAnalysiser.anslysisData.count), color: Color("green"), label: "总任务")
                    ],valuedescribe: "次")
                    .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 40 , height: 350))
                    .PieSetCharTitle("任务完成度")
                    .PieShowLine(.never)
                    .padding()
                    .tag(1)
                    
                    if MainMode == "单日分析报告"{
                        LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)), valuedescribe: "分钟")
                               .LineViewSetTitle("休息分析")
                               .LineViewSetHeight(250)
                               .LineViewSetgradientColor(GradientColor(start: Color("pink"), end:Color("pink")))
                               .tag(2)
                              
                        LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)), valuedescribe: "分钟")
                              
                               .LineViewSetTitle("专注分析")
                               .LineViewSetgradientColor(GradientColor(start: Color("green"), end:Color("green")))
                               .LineViewSetHeight(250)
                            .tag(3)
                    }
                }
                .offset(x: 0, y: -30)
                .tabViewStyle(.page)
                   
            }
            .foregroundColor(.black)
    }
    
    var PhoneViewLand : some View{
        ScrollView{
            RoundChartView(data: [
                RoundChartData(data: SumTime(time: GetValue(time: MyAnalysiser.focustime)), label: "专注时长", color: Color("green")),
                RoundChartData(data: SumTime(time: GetValue(time: MyAnalysiser.resttime)), label: "放松时长", color: Color("pink"))
            ],Title: "学习比例图")
            .RoundCharttextColor(Color("white"))
            .RoundChartSetSize(60)
            .padding(.horizontal,idiom == .pad ? 10:0)
            
                TabView{
                    phonetext
                        .padding()
                        .tag(0)
                    
                    phoneTag
                        .padding()
                        .tag(1)
                }
                .frame(height: 230)
                .tabViewStyle(.page)
                
               
                TabView{
                    PieChartView(data: [
                        PieData(data: SumTime(time: MyAnalysiser.alltime) / 60,color: Color("pink"),label: "预定完成时长"),
                        PieData(data: MyAnalysiser.anslysisData.AdvanceAllTime / 60, color: Color("green"), label: "实际完成时长")
                    ],valuedescribe: "分钟")
                    .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 40, height: 350))
                    .PieSetCharTitle("学习效率")
                    .PieShowLine(.never)
                    .padding()
                    .tag(0)
                    
                    PieChartView(data: [
                        PieData(data: Double(MyAnalysiser.anslysisData.ForceStop),color: Color("pink"),label: "强制停止"),
                        PieData(data: Double(MyAnalysiser.anslysisData.count), color: Color("green"), label: "总任务")
                    ],valuedescribe: "次")
                    .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 40 , height: 350))
                    .PieSetCharTitle("任务完成度")
                    .PieShowLine(.never)
                    .padding()
                    .tag(1)
                    
                    if MainMode == "单日分析报告"{
                        LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)), valuedescribe: "分钟")
                               .LineViewSetTitle("休息分析")
                               .LineViewSetHeight(250)
                               .LineViewSetgradientColor(GradientColor(start: Color("pink"), end:Color("pink")))
                               .tag(2)
                              
                        LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)), valuedescribe: "分钟")
                              
                               .LineViewSetTitle("专注分析")
                               .LineViewSetgradientColor(GradientColor(start: Color("green"), end:Color("green")))
                               .LineViewSetHeight(250)
                            .tag(3)
                   }
                }
                .frame(height: 400)
                .tabViewStyle(.page)
                Color.clear.frame( height: 70)
            }
            .foregroundColor(.black)
    }
    var phonetext : some View{
        ZStack{
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .frame(width: UIScreen.main.bounds.width - 40,height: 200)
                    .shadow(color: Color("black"), radius: 5, x: 0, y: 0)
            } else {
                
                // Fallback on earlier versions
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .blur(radius: 2)
                    .frame(width: UIScreen.main.bounds.width - 40,height: 200)
                    .shadow(color: Color("black"), radius: 5, x: 0, y: 0)
            }
            
                VStack(alignment:.leading,spacing: 20){
                    HStack{
                        Text("总时长:")
                        Text("\(GetTime2(time: SumTime(time: MyAnalysiser.alltime)))")
                        
                        if self.MainMode != "单日报告分析"{
                            HStack{
                                Text("专注天数:")
                                Text("\(MyAnalysiser.DateCount)天")
                            }
                            .padding(.leading)
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    
                    HStack{
                        Text("专注总时长:")
                        Text("\(GetTime2(time: SumTime(time: GetValue(time: MyAnalysiser.focustime))))")
                        
                        HStack{
                            Text("专注任务:")
                            Text("\(MyAnalysiser.anslysisData.count)个")
                        }
                        .padding(.leading)
                    }
                    .padding(.leading)
                    
                    HStack{
                        Text("放松总时长:")
                        Text("\(GetTime2(time: SumTime(time: GetValue(time: MyAnalysiser.resttime))))")
                          
                    }
                    .padding(.leading)
                    
            
                    VStack(alignment:.leading,spacing: 15){
                        if self.MainMode == "单日报告分析"{
                            HStack{
                                Text("专注时间最长:")
                                Text("\(formatted(time:GetMyMaxTime(time: MyAnalysiser.focustime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.focustime).1))")
                            }
                            .padding(.leading)
                            
                            HStack{
                                Text("放松时间最长:")
                                Text("\(formatted(time:GetMyMaxTime(time: MyAnalysiser.resttime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.resttime).1))")
                            }
                            .padding(.leading)
                        }else{
                            HStack{
                                Text("专注时间最长:")
                                Text("\(formatted3(time:GetMyMaxTime(time: MyAnalysiser.focustime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.focustime).1))")
                            }
                            .padding(.leading)
                            HStack{
                                Text("放松时间最长:")
                                Text("\(formatted3(time:GetMyMaxTime(time: MyAnalysiser.resttime).0))-\(formatted(time:GetMyMaxTime(time: MyAnalysiser.resttime).1))")
                            }
                            .padding(.leading)
                        }
                    }
                }
        }
    }
    
    var phoneTag : some View{
        ZStack{
            if #available(iOS 15.0, *) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .frame(width: UIScreen.main.bounds.width - 40,height: 200)
                    .shadow(color: Color("black"), radius: 5, x: 0, y: 0)
            } else {
                
                // Fallback on earlier versions
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .blur(radius: 2)
                    .frame(width: UIScreen.main.bounds.width - 40,height: 200)
                    .shadow(color: Color("black"), radius: 5, x: 0, y: 0)
            }
            
            VStack(alignment:.leading){
           
                if MyAnalysiser.anslysisData.tag == []{
                    Spacer()
                    HStack{
                        Spacer()
                        Label("什么都没有留下哦", systemImage: "doc.plaintext")
                            .font(.footnote)
                            .foregroundColor(Color("gray"))
                        Spacer()
                    }
                    Spacer()
                }else{
                    ScrollView(showsIndicators: false){
                        VStack(alignment:.leading){
                            ForEach(MyAnalysiser.anslysisData.tag){ item in
                                Text(item)
                                Divider()
                            }
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 70,height: 180)
        }
        .padding(10)
       
    }
}

