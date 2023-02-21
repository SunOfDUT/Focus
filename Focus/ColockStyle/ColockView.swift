//
//  ListDetial.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI
import AVFoundation

struct PadListDetial: View {
    @State var isPortrait : Bool = UIDevice.current.orientation.isPortrait
    @State private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    @State var currentMusic = "小溪河流"
    @State var picker : [String] = ["小溪河流","大雨","雷雨","下雨","森林鸟叫","鸟叫","夏日蛙叫","海浪声"]
    @State var isplayMusic : Bool = false
    @State var timer : Timer?
    @State var rouatedegree  : Double = 0
    @State var player : AVPlayer = AVPlayer(url: Bundle.main.url(forResource: "小溪河流", withExtension: "mp3")!)
    @EnvironmentObject var mylistdata : ToDoListData
    var index : Int
    @State private var hour1 : Int = 0
    @State private var hour2 : Int = 0
    @State private var min1 : Int = 0
    @State private var min2 : Int = 0
    @State private var sec1 : Int = 0
    @State private var sec2 : Int = 0
    @State private var time : String = ""
    @State private var prectent : Double = 0
    @State private var isplay = false
    @State private var haspause = false
    @State private var showalert = false
    @State private var selctMode : [String] = ["圆钟","椭圆"]
    @State private var select : String = "椭圆"
    @State private var  showchoice : Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var show : Bool
    
    
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
            player.pause()
            mylistdata.listdata[index].isFinish = true
            mylistdata.listdata[index].EndTime = Date()
            mylistdata.listdata[index].resttime = 0
            mylistdata.dataStore()
        }
    }
    
    func ApperGetTime(){
        let distance =  mylistdata.listdata[index].resttime
        print("distance\(distance)")
        self.hour2 = Int(distance / 3600)
        let min = Int(distance) / 60 - hour2 * 60
        let second = Int(distance) - min * 60 - hour2 * 3600
        self.min1 = min / 10
        self.min2 = min - min1 * 10
        self.sec1 = second / 10
        self.sec2 = second - sec1 * 10
        print("\(second)\(min)")
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
        player.pause()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack{
            HStack{
                Button{
                    withAnimation {
                        self.presentationMode.wrappedValue.dismiss()
                        show = false
                        if isplay && !mylistdata.listdata[index].isFinish{
                            Pause()
                        }
                        if isplayMusic{
                            player.pause()
                        }
                        
                    }
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color("white"))
                }
               
                Spacer()
                
                if #available(iOS 15.0, *) {
                    Picker("", selection: $currentMusic) {
                        ForEach(picker){ item in
                            Text(item)
                                .tag(item)
                        }
                    }
                    .accentColor(Color("white"))
                }else{
                    Button{
                        withAnimation {
                            showchoice = true
                        }
                    }label: {
                        Text("\(currentMusic)")
                            .foregroundColor(Color("white"))
                    }
                }
            }
            .padding(.top)
            .padding(.top,idiom == .phone ? 10:0)
            
            Spacer()
            
            
            
            if idiom == .pad{
                PadRoundClock(isPortrait: $isPortrait, hour1: $hour1, hour2: $hour2, min1: $min1, min2: $min2, sec1: $sec1, sec2: $sec2)
            }else{
                PhoneRoundClock(isPortrait: $isPortrait, hour1: $hour1, hour2: $hour2, min1: $min1, min2: $min2, sec1: $sec1, sec2: $sec2)
                Spacer()
            }

            ZStack{
                if #available(iOS 15.0, *){
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
                        .padding()
                }else{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.clear)
                        .blur(radius: 2)
                        .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
                        .padding()
                }
              
                HStack{
                    if !mylistdata.listdata[index].isFinish{
                        Spacer()
                        
                        Button{
                            withAnimation {
                                showalert = true
                            }
                        }label: {
                            if #available(iOS 15.0, *) {
                                Image(systemName: "stop.fill")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 18))
                                    .frame(width: 50, height: 50)
                                    .background(.gray.opacity(0.2),in: Circle())
                            } else {
                                // Fallback on earlier versions
                                ZStack{
                                    Circle()
                                        .foregroundColor(.gray.opacity(0.2))
                                    Image(systemName: "stop.fill")
                                        .foregroundColor(Color("green"))
                                        .font(.system(size: 18))
                                }
                                .frame(width: 50, height: 50)
                            }
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
                            if #available(iOS 15.0, *) {
                                Image(systemName: isplay ?  "pause":"play")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 18))
                                    .frame(width: 50, height: 50)
                                    .background(.gray.opacity(0.2),in: Circle())
                            } else {
                                // Fallback on earlier versions
                                ZStack{
                                    Circle()
                                        .foregroundColor(.gray.opacity(0.2))
                                    Image(systemName: isplay ?  "pause":"play")
                                        .foregroundColor(Color("green"))
                                        .font(.system(size: 18))
                                }
                                .frame(width: 50, height: 50)
                                   
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button{
                        if isplayMusic{
                            player.pause()
                        }else{
                            player.play()
                        }
                        isplayMusic.toggle()
                    }label: {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "music.note")
                                .foregroundColor(Color("green"))
                                .font(.system(size: 18))
                                .frame(width: 50, height: 50)
                                .background(.gray.opacity(0.2),in: Circle())
                                .rotationEffect(.degrees(rouatedegree))
                        } else {
                            ZStack{
                                Circle()
                                    .foregroundColor(.gray.opacity(0.2))
                                Image(systemName: "music.note")
                                    .foregroundColor(Color("green"))
                                    .font(.system(size: 18))
                            }
                            .frame(width: 50, height: 50)
                            .rotationEffect(.degrees(rouatedegree))
                        }
                    }
                    
                    Spacer()
                }
            }
            .frame(height: 100)
            .padding(.vertical,10)
           
            if idiom == .pad{
                Spacer()
            }
        }
        .onChange(of: currentMusic) { newValue in
            player.pause()
            player = AVPlayer(url: Bundle.main.url(forResource: "\(currentMusic)", withExtension: "mp3")!)
            player.play()
            isplayMusic = true
        }
        .onChange(of: player.currentTime(), perform: { newValue in
            if mylistdata.listdata[index].isFinish{
                player.pause()
            }
            if newValue == player.currentItem?.forwardPlaybackEndTime{
                player = AVPlayer(url: Bundle.main.url(forResource: "\(currentMusic)", withExtension: "mp3")!)
                player.play()
            }
        })
        .onChange(of: player.currentTime(), perform: { newValue in
             let observer = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (time) in
                 let total = CMTimeGetSeconds((player.currentItem?.duration)!)
                 if player.currentTime().seconds == Double(total){
                     player = AVPlayer(url: Bundle.main.url(forResource: "\(currentMusic)", withExtension: "mp3")!)
                     player.play()
                     isplayMusic = true
                 }
             }
        })
        .onChange(of: isplayMusic) { newValue in
            if newValue == true{
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { time in
                    withAnimation {
                        self.rouatedegree += 1
                    }
                })
            }else{
                withAnimation {
                    timer?.invalidate()
                    self.rouatedegree = 0
                }
            }
        }
        .sheet(isPresented: $showchoice, content: {
            Picker("", selection: $currentMusic) {
                ForEach(picker){ item in
                    Text(item)
                        .tag(item)
                }
            }
            .accentColor(Color("white"))
        })
        .padding()
        .background(Color("fadegreen"))
        .ignoresSafeArea()
        .onAppear {
            ApperGetTime()
            withAnimation{
                if mylistdata.listdata[index].pauseTime.count != 0{
                    mylistdata.listdata[index].startTime.append(Date())
                    mylistdata.dataStore()
                }
                isplay = true
            }
        }
        .onChange(of: self.isplay) { newValue in
            print(mylistdata.listdata[index].resttime)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { time in
                if isplay{
                    self.GetHourAndMin()
                }
            }
        }
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


//struct ListDetial_Previews: PreviewProvider {
//    static var previews: some View {
//        ListDetial(index:0)
//            .previewInterfaceOrientation(.portrait)
//            .environmentObject(ToDoListData(initListData()))
//    }
//}
