//
//  GraphicalAnalysis.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/29.
//

import SwiftUI

struct GraphicalAnalysis: View {
    @Binding var isPortrait : Bool 
    @State private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    @ObservedObject var MyAnalysiser : Analysiser
    @EnvironmentObject var MyAllData : AllData
    @State private var SelectMode : String = "学习曲线"
    @State private var AllSelect : [String] = ["学习曲线","学习饼状图","学习时间高峰图"]
    @Binding var MainMode : String
    @State private var select : Int = 0
    
    var body: some View {
        if idiom == .pad{
            Group{
            if !isPortrait{
                if GetValue(time:MyAnalysiser.focustime).count != 0 && GetValue(time:MyAnalysiser.focustime).count != 0{
                    switch MainMode{
                        case "单日报告分析":
                            TabView{
                                PieChartView(data: [
                                    PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 60, color: Color("green"), label: "专注"),
                                    PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 60, color: Color("pink"), label: "放松")
                                ], valuedescribe: "分钟")
                                .PieSetCharTitle("学习效率")
                                .PieSetChartSize(CGSize(width:UIScreen.main.bounds.width - 100, height: 450))
                                .PieShowLine(.choicetime)
                                .tag(0)
                                
                                 LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)), valuedescribe: "分钟")
                                        .LineViewSetHeight(450)
                                        .LineViewSetTitle("休息时间分析")
                                        .LineViewSetBackground(Color("white"))
                                        .LineViewSetgradientColor(GradientColor(start: Color("pink"), end:Color("pink")))
                                       
                                    .tag(1)
                           
                                 LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)), valuedescribe: "分钟")
                                        .LineViewSetHeight(450)
                                        .LineViewSetTitle("专注时间分析")
                                        .LineViewSetBackground(Color("white"))
                                        .LineViewSetgradientColor(GradientColor(start: Color("green"), end:Color("green")))
                                        .tag(2)
                            }
                            .tabViewStyle(.page)
                        default:
                            if MyAnalysiser.RestDistribute.value.count > 2{
                                 TabView(selection: $select){
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
                                                     .MultiLineViewSetTitle("多样本分析")
                                                 .MultiLineViewSetlegendTextColor(Color("black"))
                                                 .MultiLineViewSetBackground(Color("white"))
                                                 .MultiLineViewSetdropShadowColor(Color("black"))
                                                 .MultlLineViewSetHeight(UIScreen.main.bounds.width / 3)
                                        
                                     }
                                     .padding(.top,30)
                                     .tag(0)
                                     
                                   
                                     BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)))
                                         .BarSetCharTitle("休息统计图")
                                         .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                                         .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
                                 
                                         .tag(1)
                                     
                                     BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)))
                                         .BarSetCharTitle("专注统计图")
                                         .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                                         .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
                                         .tag(2)
                                     
                                     VStack{
                                             HStack(spacing:20){
                                                 // 学习总时长 / 学习放松时长
                                                 // 放松次数 任务次数 强制停止次数
                                                 PieChartView(data: [
                                                     PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 60, color: Color("green"), label: "专注"),
                                                     PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 60, color: Color("pink"), label: "放松")
                                                 ], valuedescribe: "分钟")
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
                                     .tag(3)
                                 }
                                 .tabViewStyle(.page)
                            }else{
                                TabView(selection: $select){
                                    VStack{
                                            HStack(spacing:20){
                                                // 学习总时长 / 学习放松时长
                                                // 放松次数 任务次数 强制停止次数
                                                PieChartView(data: [
                                                    PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 60, color: Color("green"), label: "专注"),
                                                    PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 60, color: Color("pink"), label: "放松")
                                                ], valuedescribe: "分钟")
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
                                    .tag(0)
                                }
                                .tabViewStyle(.page)
                            }
                    }
                    
                }else{
                    VStack{
                        Spacer()
                        Label {
                            Text("样本数据太少")
                        } icon: {
                            Image(systemName: "doc.plaintext")
                        }
                        Spacer()
                    }
                }
            }else{
                    if GetValue(time:MyAnalysiser.focustime).count != 0 && GetValue(time:MyAnalysiser.focustime).count != 0{
                        PadPortraitView
                    }else{
                        VStack{
                            Spacer()
                            Label {
                                Text("样本数据太少")
                            } icon: {
                                Image(systemName: "doc.plaintext")
                            }
                            Spacer()
                        }
                    }
            }
        }
        }else if idiom == .phone{
            if isPortrait{
                if GetValue(time:MyAnalysiser.focustime).count != 0 && GetValue(time:MyAnalysiser.focustime).count != 0{
                    PhoneViewPro
                }else{
                    VStack{
                        Spacer()
                        Label {
                            Text("样本数据太少")
                        } icon: {
                            Image(systemName: "doc.plaintext")
                        }
                        Spacer()
                    }
                }
            }else{
                Spacer()
                Text("不支持横屏查看")
                Spacer()
            }
      
    }
}
    
    var PadPortraitView : some View{
        ScrollView{
            VStack(spacing:20){
                
                HStack(spacing:20){
                    // 学习总时长 / 学习放松时长
                    // 放松次数 任务次数 强制停止次数
                    Spacer()
                        PieChartView(data: [
                            PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 60, color: Color("green"), label: "专注"),
                            PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 60, color: Color("pink"), label: "放松")
                        ], valuedescribe: "分钟")
                        .PieSetCharTitle("学习效率")
                        .PieSetChartSize(CGSize(width: 380, height: 400))
                        .PieShowLine(.choicetime)
                  
                        Spacer()
                        PieChartView(data: [
                            PieData(data: Double(MyAnalysiser.anslysisData.count), color: Color("yellow"), label: "任务"),
                            PieData(data: Double(MyAnalysiser.anslysisData.ForceStop), color: Color("pink"), label: "强制制止"),
                            PieData(data: Double(MyAnalysiser.RestDistribute.value.count),color: Color("green"), label: "暂停")
                        ], valuedescribe: "次")
                        .PieSetCharTitle("学习完成度")
                        .PieSetChartSize(CGSize(width: 380, height: 400))
                        .PieShowLine(.choicetime)
                    Spacer()
                    
                }
                
                if MyAnalysiser.FocusDistribute.value.count > 2{
                switch MainMode{
                    case "单日报告分析":
                        VStack{
                      
                                    LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)), valuedescribe: "分钟")
                                 
                                    .LineViewSetTitle("休息时间分析")
                                    .LineViewSetBackground(Color("white"))
                                    .LineViewSetgradientColor(GradientColor(start: Color("pink"), end:Color("pink")))
                       
                                LineView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)), valuedescribe: "分钟")

                                    .LineViewSetTitle("专注时间分析")
                                    .LineViewSetBackground(Color("white"))
                                    .LineViewSetgradientColor(GradientColor(start: Color("green"), end:Color("green")))
                            
                        }
                    default:
                            TabView{
                                BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)))
                                    .BarSetCharTitle("休息统计图")
                                    .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                                    .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
                                    .tag(0)
                                BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)))
                                    .BarSetCharTitle("专心统计图")
                                    .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                                    .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
                                    .tag(1)
                            }
                            .frame(height: 450)
                            .tabViewStyle(.page)
                            
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
                            .MultiLineViewSetTitle("多样本分析")
                            .MultiLineViewSetlegendTextColor(Color("black"))
                            .MultiLineViewSetBackground(Color("white"))
                            .MultiLineViewSetdropShadowColor(Color("black"))
                        }
                }
                
                Color.clear.frame(height: 40)
                Spacer()
            }
            .padding(.top,40)
        }
    }
    
    var PhoneViewPro : some View{
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
            }else{
                if MyAnalysiser.RestDistribute.value.count > 2{
                BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)))
                    .BarSetCharTitle("休息统计图")
                    .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                    .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
            
                    .tag(2)
                
                BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)))
                    .BarSetCharTitle("专注统计图")
                    .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                    .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 50, height: 400))
                    .tag(3)
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
                .MultiLineViewSetTitle("多样本分析")
                .MultiLineViewSetlegendTextColor(Color("black"))
                .MultiLineViewSetBackground(Color("white"))
                .MultiLineViewSetdropShadowColor(Color("black"))
                .MultlLineViewSetHeight(300)
                .tag(4)
            }
        }
    }
    .tabViewStyle(.page)
    }
    
    var PhoneLandSpace : some View{
        TabView{
            switch MainMode{
                case "单日报告分析":
                    PieChartView(data: [
                        PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 60, color: Color("green"), label: "专注"),
                        PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 60, color: Color("pink"), label: "放松")
                    ], valuedescribe: "分钟")
                        .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 200))
                        .PieShowLine(.never)
                        .tag(0)

                    PieChartView(data: [
                        PieData(data: Double(MyAnalysiser.anslysisData.count), color: Color("yellow"), label: "任务"),
                        PieData(data: Double(MyAnalysiser.anslysisData.ForceStop), color: Color("pink"), label: "强制制止"),
                        PieData(data: Double(MyAnalysiser.RestDistribute.value.count), color: Color("green"), label: "暂停")
                    ], valuedescribe: "次")
                        .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 200))
                        .PieShowLine(.never)
                    .tag(1)
                    
                default :
                    PieChartView(data: [
                        PieData(data: SumTime(time:GetValue(time: MyAnalysiser.focustime)) / 60, color: Color("green"), label: "专注"),
                        PieData(data: SumTime(time:GetValue(time: MyAnalysiser.resttime)) / 60, color: Color("pink"), label: "放松")
                    ], valuedescribe: "分钟")
                        .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 200))
                        .PieShowLine(.never)
                    .tag(0)

                    PieChartView(data: [
                        PieData(data: Double(MyAnalysiser.anslysisData.count), color: Color("yellow"), label: "任务"),
                        PieData(data: Double(MyAnalysiser.anslysisData.ForceStop), color: Color("pink"), label: "强制制止"),
                        PieData(data: Double(MyAnalysiser.RestDistribute.value.count), color: Color("green"), label: "暂停")
                    ], valuedescribe: "次")
                        .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 200))
                        .PieShowLine(.never)
                    .tag(1)
                    if MyAnalysiser.FocusDistribute.value.count > 2{
                        BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.RestDistribute)))
                            .BarSetCharTitle("休息统计图")
                            .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                            .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 200))
                            .tag(2)
                        BarChartView(data: ChartData(values: MyAnalysiser.Getstandarddata(data: MyAnalysiser.FocusDistribute)))
                            .BarSetCharTitle("专心统计图")
                            .BarSetChartgradientColor(GradientColor(start: Color("green"), end: Color("fadegreen")))
                            .BarSetChartSize(CGSize(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height - 200))
                            .tag(3)
                        MultiLineView(data: MultiLineData(
                            lineData: [
                                //第一条线是我们的每一天的放松时间
                                oneLineData(data: MyAnalysiser.RestDistribute.value.map{$0 / 60}, lineColor: GradientColor(start: Color("pink"), end:Color("pink")),lineLabel: "放松"),
                                oneLineData(data: MyAnalysiser.FocusDistribute.value.map{$0 / 60}, lineColor: GradientColor(start: Color("green"), end: Color("green")),lineLabel: "专注"),
                                oneLineData(data: MyAnalysiser.TaskCount.value, lineColor: GradientColor(start: Color("yellow"), end: Color("yellow")),lineLabel: "任务总数"),
                                oneLineData(data: MyAnalysiser.RestCount.value, lineColor: GradientColor(start: .red, end: .red),lineLabel: "休息总数")
                            ]
                            ,Ylabel: MyAnalysiser.RestDistribute.day)
                            ,valuedescribe: "分钟")
                            .MultiLineViewSetlegendTextColor(Color("white"))
                            .MultiLineViewSetBackground(Color("white"))
                            .MultlLineViewSetHeight(UIScreen.main.bounds.height - 335)
                            .tag(4)
                    }
            }
        }
        .frame(height: UIScreen.main.bounds.height - 160)
        .tabViewStyle(.page)
        .offset( y: 20)
    }
}
