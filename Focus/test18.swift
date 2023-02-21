//
//  test18.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/3.
//

import SwiftUI
@available(iOS 15.0, *)
struct test18: View {
    @State var isPortrait : Bool = UIDevice.current.orientation.isPortrait
    @State private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    @EnvironmentObject var mylistdata : ToDoListData
    var index : Int
    @State private var hour1 : Int = 0
    @State private var hour2 : Int = 0
    @State private var min1 : Int = 0
    @State private var min2 : Int = 0
    @State private var sec1 : Int = 0
    @State private var sec2 : Int = 0
    @State private var time : String = "12h"
    @State private var prectent : Double = 0.8
    @State private var isplay = false
    @State private var haspause = false
    @State private var showalert = false
    @State private var selctMode : [String] = ["圆钟","椭圆"]
    @State private var select : String = "椭圆"
    @Environment(\.presentationMode) var presentationMode
    
    func GetHourAndMin(){
        let EndTime = Date(timeInterval: mylistdata.listdata[index].resttime,since: mylistdata.listdata[index].startTime.isEmpty ? mylistdata.listdata[index].createtime:mylistdata.listdata[index].startTime.last!)
        let distance  = (Date().distance(to: EndTime))
        guard distance >= 0 else {return}
        self.time = GetTime4(time: distance)
        self.prectent = distance / mylistdata.listdata[index].time
        self.hour2 = Int(distance / 3600)
        print(prectent)
        print(time)
        let min = Int(distance) / 60 - hour2 * 60
        let second = Int(distance) - min * 60 - hour2 * 3600
        self.min1 = min / 10
        self.min2 = min - min1 * 10
        self.sec1 = second / 10
        self.sec2 = second - sec1 * 10
        if hour2 == 0 && min == 0 && second == 0{
            mylistdata.listdata[index].isFinish = true
            mylistdata.listdata[index].EndTime = Date()
            mylistdata.listdata[index].resttime = 0
            mylistdata.dataStore()
            SendNot()
        }
    }
    
    func ApperGetTime(){
        let distance =  mylistdata.listdata[index].resttime
        print(distance)
        self.hour2 = Int(distance / 3600)
        let min = Int(distance) / 60 - hour2 * 60
        let second = Int(distance) - min * 60 - hour2 * 3600
        self.min1 = min / 10
        self.min2 = min - min1 * 10
        self.sec1 = second / 10
        self.sec2 = second - sec1 * 10
    }
    
    func Pause(){
        let distance = -(Date().distance(to:mylistdata.listdata[index].startTime.isEmpty ? mylistdata.listdata[index].createtime:mylistdata.listdata[index].startTime.last!)) // 已经计时过的
        mylistdata.listdata[index].pauseTime.append(Date())
        mylistdata.listdata[index].resttime -= distance
        guard mylistdata.listdata[index].resttime > 0 else{
            mylistdata.listdata[index].resttime = 0
            mylistdata.listdata[index].isFinish = true
            mylistdata.dataStore()
            return
        }
        mylistdata.dataStore()
    }
    
    func stop(){
        mylistdata.listdata[index].resttime = 0
        mylistdata.listdata[index].EndTime = Date()
        mylistdata.listdata[index].isFinish = true
        mylistdata.listdata[index].isFroceStop = true
        mylistdata.dataStore()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    withAnimation {
//                        self.presentationMode.wrappedValue.dismiss()
//                        if isplay && !mylistdata.listdata[index].isFinish{
//                            Pause()
//                        }
                    }
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.white)
                }
               
              Spacer()
             
            }
            
            Spacer()
          
//            PhoneCircleColock(isPortrait: $isPortrait,circleSize:200,Circle: .gray,water: Color("yellow"),time: $time, precent: $prectent)
            
            
//            PhoneRoundClock(isPortrait: <#T##Binding<Bool>#>, hour1: <#T##Binding<Int>#>, hour2: <#T##Binding<Int>#>, min1: <#T##Binding<Int>#>, min2: <#T##Binding<Int>#>, sec1: <#T##Binding<Int>#>, sec2: <#T##Binding<Int>#>)
            
            Spacer()
            
            HStack{
               
                    Spacer()
                    
                    Button{
                        withAnimation {
                            showalert = true
                        }
                    }label: {
                        Image(systemName: "stop.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .frame(width: 50, height: 50)
                            .background(.gray.opacity(0.2))
                    }
                    
                    Spacer()
                    
                    Button{
                        isplay.toggle()
                        if !isplay{
                            Pause()
                        }else{
                            mylistdata.listdata[index].startTime.append(Date())
                            mylistdata.dataStore()
                        }
                        haspause = true
                    }label: {
                        Image(systemName: isplay ?  "pause":"play")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .frame(width: 50, height: 50)
                            .background(.gray.opacity(0.2))
                    }
                
                
                Spacer()
                
                Button{
                    
                }label: {
                    Image(systemName: "music.note")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .frame(width: 50, height: 50)
                        .background(.gray.opacity(0.2))
                }
                
                Spacer()
            }
            .padding()
            .frame(height: 80)
            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius:40))
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
        }
        .padding()
        .background(Color("fadegreen"))
        .onAppear {
//            ApperGetTime()
//            withAnimation{
//                if mylistdata.listdata[index].pauseTime.count != 0{
//                    mylistdata.listdata[index].startTime.append(Date())
//                    mylistdata.dataStore()
//                }
//                isplay = true
//            }
        }
//        .onChange(of: self.isplay) { newValue in
//            print(mylistdata.listdata[index].resttime)
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { time in
//                if isplay{
//                    self.GetHourAndMin()
//                }
//            }
//        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { bool in
            guard let scene = UIApplication.shared.windows.first?.windowScene else {return}
            self.isPortrait = scene.interfaceOrientation.isPortrait
            print(isPortrait)
        })
        .alert(isPresented:$showalert){
            Alert(title: Text("确定要终止掉该任务吗?"), primaryButton: Alert.Button.cancel(Text("取消")), secondaryButton: Alert.Button.destructive(Text("确定"),action: {
                stop()
            }))
        }
    }
}
//
struct test18_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            test18(index: 0)
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
}
