//
//  ListDetial.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI

struct SingleList: View {
    @EnvironmentObject var mylistdata : ToDoListData
    @State var animation : Bool = false
    var index : Int
    var body: some View{
        HStack(alignment:.top){
        VStack(alignment:.leading,spacing: 10){
            Text(mylistdata.listdata[index].name == ""  ? "专注事项\(index+1)":mylistdata.listdata[index].name)
                .padding(.top,4)
            HStack{
                Text(GetTime(createtime:mylistdata.listdata[index].createtime,EndTime:mylistdata.listdata[index].EndTime))
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
        }
        
        
        GeometryReader{ proxy in
            if #available(iOS 15.0, *) {
                HStack{
                    Text("\(Int((1-(mylistdata.listdata[index].resttime / mylistdata.listdata[index].time)) * 100))%")
                        .foregroundColor(Color("white"))
                        .opacity(proxy.frame(in: .local).width * (1-(mylistdata.listdata[index].resttime / mylistdata.listdata[index].time)) > 30 ? 1:0)
                    if mylistdata.listdata[index].isFinish{
                        Text("已经完成第\(index+1)项任务,真棒!")
                            .foregroundColor(Color("white"))
                    }
                }
                .frame(width: animation ?  proxy.frame(in: .local).width * (1-(mylistdata.listdata[index].resttime / mylistdata.listdata[index].time)) : 0,height:50)
                .background(Color("green"),in: Capsule(style: .continuous))
            } else {
                // Fallback on earlier versions
                ZStack{
                    Capsule(style: .continuous)
                        .foregroundColor(Color("green"))
                    HStack{
                        Text("\(Int((1-(mylistdata.listdata[index].resttime / mylistdata.listdata[index].time)) * 100))%")
                            .foregroundColor(Color("white"))
                            .opacity(proxy.frame(in: .local).width * (1-(mylistdata.listdata[index].resttime / mylistdata.listdata[index].time)) > 30 ? 1:0)
                        if mylistdata.listdata[index].isFinish{
                            Text("已经完成第\(index+1)项任务,真棒!")
                                .foregroundColor(Color("white"))
                        }
                    }
                }
               
                .frame(width: animation ?  proxy.frame(in: .local).width * (1-(mylistdata.listdata[index].resttime / mylistdata.listdata[index].time)) : 0,height:50)
            }
        }
     }
    .onAppear{
        print("第\(index)剩余\(mylistdata.listdata[index].resttime)比例\(mylistdata.listdata[index].resttime /  mylistdata.listdata[index].time)")
        withAnimation(.spring()){
            animation = true
            guard mylistdata.listdata[index].resttime > 0 else {
                mylistdata.listdata[index].resttime = 0
                mylistdata.listdata[index].isFinish = true
                mylistdata.dataStore()
                return
            }
            if mylistdata.listdata[index].isFinish{
                mylistdata.listdata[index].resttime = 0
                mylistdata.dataStore()
            }
        }
    
    }
}
    
    func GetTimeInterval(createtime:Date,starttime:Date,endtime:Date)->Double{
        let alltime = createtime.distance(to: Date())
        let onetime = starttime.distance(to: endtime)
        return onetime / alltime
    }
}

func SendNot(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { isallow, fail in
        if isallow{
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
            let not = UNMutableNotificationContent()
            not.sound = .default
            not.title = "计时已完成!"
            let request = UNNotificationRequest(identifier: "通知名称", content: not, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
}


 

//func Getall(){
////        print(mylistdata.listdata[index])
//    let count = mylistdata.listdata[index].pauseTime.count
//    let endtime =  mylistdata.listdata[index].EndTime
//    let alldistacnce = mylistdata.listdata[index].isFinish ? mylistdata.listdata[index].createtime.distance(to: endtime):mylistdata.listdata[index].time
//    if count == 1{
//        let distance = mylistdata.listdata[index].pauseTime[0].distance(to: mylistdata.listdata[index].createtime)
//        self.alltime.append(abs(distance) / alldistacnce)
//        
//        if mylistdata.listdata[index].startTime.count >= 1{
//            let distance2 = mylistdata.listdata[index].startTime[0].distance(to: mylistdata.listdata[index].pauseTime[0])
//            self.alltime.append(abs(distance2) / alldistacnce)
//            let enddistance = endtime.distance(to: mylistdata.listdata[index].startTime[0])
//            self.alltime.append(abs(enddistance) / alldistacnce)
//        }else{
//            let enddistance = endtime.distance(to: mylistdata.listdata[index].pauseTime[0])
//            self.alltime.append(abs(enddistance) / alldistacnce)
//        }
//    }else{
//        for i in 0..<count{
//            if i == 0{
//                let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].createtime)
//                self.alltime.append(abs(distance) / alldistacnce)
//                
//                if mylistdata.listdata[index].startTime.count >= i+1{
//                    let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
//                    self.alltime.append(abs(distance2) / alldistacnce)
//                }
//            }else if i == count-1{
//                let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].startTime[i-1])
//                self.alltime.append(abs(distance) / alldistacnce)
//                
//                if mylistdata.listdata[index].startTime.count >= i+1{
//                    let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
//                    self.alltime.append(abs(distance2) / alldistacnce)
//                    let distanceend = mylistdata.listdata[index].startTime[i].distance(to: endtime)
//                    self.alltime.append(abs(distanceend) / alldistacnce)
//                }else{
//                    let distanceend = mylistdata.listdata[index].pauseTime[i].distance(to: endtime)
//                    self.alltime.append(abs(distanceend) / alldistacnce)
//                }
//            }else{
//                let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].startTime[i-1])
//                self.alltime.append(abs(distance) / alldistacnce)
//                
//                if mylistdata.listdata[index].startTime.count >= i+1{
//                    let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
//                    self.alltime.append(abs(distance2) / alldistacnce)
//                }
//            }
//        }
//    }
//    if count == 0{
//        let time = mylistdata.listdata[index].isFinish ? endtime:Date()
//        let distance = mylistdata.listdata[index].createtime.distance(to:time)
//        print(distance)
//        alltime.append(distance / mylistdata.listdata[index].time)
//    }
//    var item : Double = 0.0
//    for i in alltime{
//        item += i
//    }
//    print(item)
// }
