//
//  test.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI


struct OldFinishDetial: View {
    @EnvironmentObject var mylistdata : ToDoListData
    var linewidth :CGFloat = 4
    @State var color : [Color] = [.purple,.pink,.purple]
    var index : Int
    @State var alltime : TimeInterval = 1
    @State var focustime : TimeInterval = 0
    @State var resttime : TimeInterval = 0
    
    var body: some View {
        VStack(alignment:.leading,spacing: 20){
            Text("恭喜你 已经完成了本次专注")
                .font(.largeTitle)
            
            HStack{
                Text("\(formatted(time:mylistdata.listdata[index].createtime))-\(formatted(time:mylistdata.listdata[index].EndTime))")
                    .font(.largeTitle)
                if alltime > mylistdata.listdata[index].time{
                    Text("超出预定时长")
                }else if mylistdata.listdata[index].isFroceStop{
                    Text("被提前终止")
                }
            }
            
            VStack(alignment:.leading,spacing: 20){
                HStack{
                    Text("本次专注时长")
                    Text("\(GetTime2(time: focustime))")
                    Spacer()
                    ZStack{
                        Text("\(Int((focustime / alltime) * 100))%")
                    Circle()
                        .trim(from: 0, to:CGFloat(focustime / alltime))
                        .stroke(style: StrokeStyle(lineWidth: linewidth, lineCap: .round))
                        .fill(.angularGradient(colors: color, center: .center, startAngle: .degrees(0), endAngle: .degrees(60)))
                        .frame(width:80,height: 80)
                        .animation(.easeInOut(duration: 0.5), value:self.alltime)
                    }
                }
                
                HStack{
                    Text("本次休息时长")
                    Text("\(GetTime2(time:resttime))")
                    Text("中途暂停次数:\(mylistdata.listdata[index].pauseTime.count)次")
                    Spacer()
                    
                    ZStack{
                        Text("\(100 - Int((focustime / alltime) * 100))%")
                    Circle()
                        .trim(from: 0, to:CGFloat(resttime / alltime ))
                        .stroke(style: StrokeStyle(lineWidth: linewidth, lineCap: .round))
                        .fill(.angularGradient(colors: color, center: .center, startAngle: .degrees(0), endAngle: .degrees(60)))
                        .frame(width:80,height: 80)
                        .animation(.default, value: self.alltime)
                    }
                }
                
                HStack{
                    Text("学习效率")
                    Text(mylistdata.listdata[index].time / alltime < 1 ? "\(Int((mylistdata.listdata[index].time / alltime) * 100))%":"\(Int((alltime / mylistdata.listdata[index].time) * 100))%")
                    Spacer()
                    ZStack{
                        Text(mylistdata.listdata[index].time / alltime < 1 ? "\(Int((mylistdata.listdata[index].time / alltime) * 100))%":"\(Int((alltime / mylistdata.listdata[index].time) * 100))%")
                        Circle()
                            .trim(from: 0, to:CGFloat(mylistdata.listdata[index].time / alltime < 1 ? mylistdata.listdata[index].time / alltime :  alltime / mylistdata.listdata[index].time ))
                            .stroke(style: StrokeStyle(lineWidth: linewidth, lineCap: .round))
                            .fill(.angularGradient(colors: color, center: .center, startAngle: .degrees(0), endAngle: .degrees(60)))
                            .frame(width:80,height: 80)
                            .animation(.default, value: self.alltime)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            withAnimation{
        //        print(mylistdata.listdata[index])
                let count = mylistdata.listdata[index].pauseTime.count
                let endtime = mylistdata.listdata[index].isFinish ? mylistdata.listdata[index].EndTime : Date()
                if count == 1{
                    let distance = mylistdata.listdata[index].pauseTime[0].distance(to: mylistdata.listdata[index].createtime)
                    self.focustime += abs(distance)
                    
                    if mylistdata.listdata[index].startTime.count >= 1{
                        let distance2 = mylistdata.listdata[index].startTime[0].distance(to: mylistdata.listdata[index].pauseTime[0])
                        self.resttime += abs(distance2)
                        
                        let enddistance = endtime.distance(to: mylistdata.listdata[index].startTime[0])
                        self.focustime += abs(enddistance)
                        
                    }else{
                        let enddistance = endtime.distance(to: mylistdata.listdata[index].pauseTime[0])
                        self.focustime += abs(enddistance)
                    }
                }else{
                    for i in 0..<count{
                        if i == 0{
                            let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].createtime)
                            self.focustime += abs(distance)
                            
                            if mylistdata.listdata[index].startTime.count >= i+1{
                                let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
                                self.resttime += abs(distance2)
                            }
                        }else if i == count-1{
                            let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].startTime[i-1])
                            self.focustime += abs(distance)
                            
                            if mylistdata.listdata[index].startTime.count >= i+1{
                                let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
                                self.resttime += abs(distance2)
                                
                                let distanceend = mylistdata.listdata[index].startTime[i].distance(to: endtime)
                                self.focustime += abs(distanceend)
                            }else{
                                let distanceend = mylistdata.listdata[index].pauseTime[i].distance(to: endtime)
                                self.focustime += abs(distanceend)
                            }
                        }else{
                            let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].startTime[i-1])
                            self.focustime += abs(distance)
                            
                            if mylistdata.listdata[index].startTime.count >= i+1{
                                let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
                                self.resttime += abs(distance2)
                            }
                        }
                    }
                }
                if count == 0{
                    let time = mylistdata.listdata[index].isFinish ? endtime:Date()
                    let distance = mylistdata.listdata[index].createtime.distance(to:time)
                    print(distance)
                    self.focustime += distance
                }
            }
            self.alltime = self.focustime + self.resttime
            print(mylistdata.listdata[index].time)
            print(self.focustime)
            print(self.resttime)
            print(self.focustime + self.resttime)
        }
    }
}

