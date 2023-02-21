//
//  test.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/28.
//

import SwiftUI

struct Finish: View {
    @State var isPortrait : Bool = UIDevice.current.orientation.isPortrait
    @Environment(\.presentationMode) var presentationMode
    @State var isPresent : [Bool] = [false,false,false,false,false]
    @EnvironmentObject var mylistdata : ToDoListData
    @State var alltime :  [Double] = [1]
    @State var focustime : [Double] = [0]
    @State var resttime : [Double] = [0]
    @State var mygriend = []
    @State var CustomgradientColor: Gradient = Gradient(colors: [])
    var index : Int
    @State var showAdd : Bool = false
    @Binding var show : Bool

    func GetAll(){
        withAnimation{
    //        print(mylistdata.listdata[index])
            let count = mylistdata.listdata[index].pauseTime.count
            let endtime = mylistdata.listdata[index].isFinish ? mylistdata.listdata[index].EndTime : Date()
            self.alltime = []
            self.resttime = []
            self.focustime = []
            if count == 1{
                let distance = mylistdata.listdata[index].pauseTime[0].distance(to: mylistdata.listdata[index].createtime)
                self.focustime.append(abs(distance))
                self.alltime.append(abs(distance))
                
                if mylistdata.listdata[index].startTime.count >= 1{
                    let distance2 = mylistdata.listdata[index].startTime[0].distance(to: mylistdata.listdata[index].pauseTime[0])
                    self.resttime.append(abs(distance2))
                    self.alltime.append(abs(distance2))
                    
                    let enddistance = endtime.distance(to: mylistdata.listdata[index].startTime[0])
                    self.focustime.append(abs(enddistance))
                    self.alltime.append(abs(enddistance))
                }else{
                    let enddistance = endtime.distance(to: mylistdata.listdata[index].pauseTime[0])
                    self.focustime.append(abs(enddistance))
                    self.alltime.append(abs(enddistance))
                }
            }else{
                for i in 0..<count{
                    if i == 0{
                        let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].createtime)
                        self.focustime.append(abs(distance))
                        self.alltime.append(abs(distance))
                        
                        if mylistdata.listdata[index].startTime.count >= i+1{
                            let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
                            self.resttime.append(abs(distance2))
                            self.alltime.append(abs(distance2))
                        }
                    }else if i == count-1{
                        let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].startTime[i-1])
                        self.focustime.append(abs(distance))
                        self.alltime.append(abs(distance))
                        
                        if mylistdata.listdata[index].startTime.count >= i+1{
                            let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
                            self.resttime.append(abs(distance2))
                            self.alltime.append(abs(distance2))
                            
                            let distanceend = mylistdata.listdata[index].startTime[i].distance(to: endtime)
                            self.focustime.append(abs(distanceend))
                            self.alltime.append(abs(distanceend))
                            
                        }else{
                            let distanceend = mylistdata.listdata[index].pauseTime[i].distance(to: endtime)
                            self.focustime.append(abs(distanceend))
                            self.alltime.append(abs(distanceend))
                        }
                    }else{
                        let distance = mylistdata.listdata[index].pauseTime[i].distance(to: mylistdata.listdata[index].startTime[i-1])
                        self.focustime.append(abs(distance))
                        self.alltime.append(abs(distance))
                        
                        if mylistdata.listdata[index].startTime.count >= i+1{
                            let distance2 = mylistdata.listdata[index].startTime[i].distance(to: mylistdata.listdata[index].pauseTime[i])
                            self.resttime.append(abs(distance2))
                            self.alltime.append(abs(distance2))
                        }
                    }
                }
            }
            if count == 0{
                let time = mylistdata.listdata[index].isFinish ? endtime:Date()
                let distance = mylistdata.listdata[index].createtime.distance(to:time)
                print(distance)
                self.focustime.append(abs(distance))
                self.alltime.append(abs(distance))
            }
        }
        print(mylistdata.listdata[index])
        print(self.resttime)
        print(GetMaxtime(time: self.resttime))
//        print(self.alltime)
//        print(mylistdata.listdata[index].createtime)
//        print(mylistdata.listdata[index].startTime)
//        print(mylistdata.listdata[index].pauseTime)
//        print(mylistdata.listdata[index].EndTime)
    }
    
    func GetMaxtime(time:[Double])->Int{
        var maxint : Int = 0
        for i in 0..<time.count{
            if time[i] == time.max(){
                maxint = i
            }
        }
        return maxint
    }
    func HandelTime()->[Double]{
        var handel = self.alltime.map{$0 / 60}
        handel.insert(0, at: 0)
        return handel
    }
        var body: some View {
            VStack{
                if isPortrait{
                    allview
                }else{
                    allview
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { bool in
                guard let scene = UIApplication.shared.windows.first?.windowScene else {return}
                self.isPortrait = scene.interfaceOrientation.isPortrait
                print(isPortrait)
            })
        }
    
    var allview : some View{
        ScrollView{
        VStack(alignment:.leading,spacing: 20){
            HStack{
                Text("专注报告")
                    .font(.largeTitle)
                Spacer()
                Button{
                    presentationMode.wrappedValue.dismiss()
                    withAnimation {
                        show = false
                    }
                }label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("black"))
                }
                .font(.system(size: 25))
            }
            .padding(.top,30)
            .padding(.horizontal)
            .opacity(isPresent[0] ? 1:0)
            
            HStack{
                Text("\(formatted(time:mylistdata.listdata[index].createtime))-\(formatted(time:mylistdata.listdata[index].EndTime))")
                    .foregroundColor(Color("gray"))
                if mylistdata.listdata[index].isFroceStop{
                    Text("被强制中断任务")
                         .font(.footnote)
                }else{
                    if abs(mylistdata.listdata[index].createtime.distance(to: mylistdata.listdata[index].EndTime)) >  mylistdata.listdata[index].time{
                        Text("超出预定时长")
                             .font(.footnote)
                    }else if abs(mylistdata.listdata[index].createtime.distance(to: mylistdata.listdata[index].EndTime)) ==  mylistdata.listdata[index].time{
                        Text("准时完成任务")
                             .font(.footnote)
                    }else{
                        Text("提前完成任务")
                             .font(.footnote)
                    }
                }
                Spacer()
            }
            .opacity(isPresent[0] ? 1:0)
            .padding(.horizontal)
          
                ZStack{
                   
                    VStack(alignment:.leading,spacing: 20){
                        RoundChartView(data: [
                            RoundChartData(data: SumTime(time: self.focustime), label: "专注时长", color: Color("green")),
                            RoundChartData(data: SumTime(time: self.resttime), label: "放松时长", color: Color("pink"))
                        ],Title: "比例图")
                        .RoundCharttextColor(Color("white"))
                        .RoundChartSetSize(70)
                        
                        HStack(alignment:.top){
                            VStack(alignment:.leading,spacing: 20){
                                HStack{
                                    Text("暂停次数:")
                                    Text("\(mylistdata.listdata[index].pauseTime.count)次")
                                }
                               
                                HStack{
                                    Text("暂停时长:")
                                    Text(GetTime2(time:SumTime(time:resttime)))
                                }
                              
                            }
                            .padding(.trailing)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.vertical)
                    .opacity(isPresent[1] ? 1:0)
                }

          
            HStack{
                Text("分析")
                    .bold()
                Spacer()
                Label("添加标签", systemImage: "plus")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
                
        ScrollView(.horizontal, showsIndicators: true){
            HStack{
                
                tagView(text:mylistdata.listdata[index].mytag.first ?? "输入你想要添加的内容",index: index)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white"))
                        .frame(width:250,height: 300)
                        .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
                        .padding(10)
                    
                    VStack(alignment:.leading,spacing: 20){
                        Text("专注时长:\(GetTime2(time:SumTime(time: focustime)))")
                        HStack{
                            Text("最专注时段:")
                           
                            if mylistdata.listdata[index].pauseTime.count > 0{
                                if GetMaxtime(time: self.focustime) == 0{
                                    Text("\(formatted(time:mylistdata.listdata[index].createtime))-\(formatted(time:mylistdata.listdata[index].pauseTime[0]))")
                                }else if GetMaxtime(time: self.focustime) == self.focustime.count - 1{
                                    Text("\(formatted(time:mylistdata.listdata[index].startTime.last!))-\(formatted(time:mylistdata.listdata[index].EndTime))")
                                }else{
                                    Text("\(formatted(time:mylistdata.listdata[index].startTime[GetMaxtime(time: self.focustime)-1]))-\(formatted(time:mylistdata.listdata[index].pauseTime[GetMaxtime(time: self.focustime)]))")
                                }
                            }else{
                                Text("\(formatted(time:mylistdata.listdata[index].createtime))-\(formatted(time:mylistdata.listdata[index].EndTime))")
                            }
                        }
                        
                        Text("分心时长:\(GetTime2(time:SumTime(time:resttime)))")
                        HStack{
                            Text("分心时段:")
                            if mylistdata.listdata[index].pauseTime.count > 0 &&  mylistdata.listdata[index].startTime.count > 0{
                                Text("\(formatted(time:mylistdata.listdata[index].pauseTime[GetMaxtime(time: self.resttime)]))-\(formatted(time:mylistdata.listdata[index].startTime[GetMaxtime(time: self.resttime)]))")
                            }
                        }
                        Spacer()
                    }
                    .padding(20)
                }
                
                PieChartView(data: [
                    PieData(data: mylistdata.listdata[index].time / 60 ,color:Color("green"),label: "预定完成时长"),
                    PieData(data:SumTime(time: self.alltime) / 60,color:Color("pink"),label: "实际完成时长")
                ], valuedescribe: "分钟")
                .PieSetCharTitle("学习效率")
                .PieSetChartSize(CGSize(width: UIScreen.main.bounds.width / 1.8, height: 300))
                
                
            }
            .padding(.vertical)
            .padding(.horizontal)
        }
              
            
            LineView(data: ChartData(points:HandelTime()), valuedescribe: "分钟")
                .LineViewSetTitle("学习曲线")
                .LineViewSetgradientColor(GradientColor(start: Color("green"), end: Color("green")))
        }
           
        }
        .foregroundColor(Color("black"))
        .onAppear {
            GetAll()
            var duration = 0.05
            for i in 0..<isPresent.count{
                withAnimation(.easeInOut.delay(duration)){
                    isPresent[i] = true
                }
                duration += 0.05
            }
        }
        .SheetCenter(isPresent: $showAdd,BackgrounColor:.black){
            addTag( isPresent: $showAdd, index: self.index)
        }
    }
}

struct tagView : View{
    @State var text : String
    @EnvironmentObject var mylistdata : ToDoListData
    var index : Int
    var body: some View{
        TextEditor(text: $text)
            .frame(width:400,height: 300)
            .mask(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
            .onChange(of: text) { newValue in
                if mylistdata.listdata[index].mytag.isEmpty{
                    mylistdata.listdata[index].mytag.append(newValue)
                }else{
                    mylistdata.listdata[index].mytag[0] = newValue
                }
                mylistdata.dataStore()
            }
    }
}

struct addTag : View{
    @EnvironmentObject var mylistdata : ToDoListData
    @Binding var isPresent : Bool
    @State var content : String = ""
    var index : Int
    
    var body: some View{
        if #available(iOS 15.0, *) {
            VStack{
                HStack{
                    Spacer()
                    Text("添加小标签")
                    Spacer()
                }
                Divider()
                HStack{
                    TextEditor(text: $content)
                }
                HStack(spacing:20){
                    Button{
                        withAnimation {
                            guard content != "" else {return}
                            isPresent = false
                            mylistdata.listdata[index].mytag.append(content)
                            mylistdata.dataStore()
                        }
                    }label: {
                        Text("确定")
                    }
                    
                    Button{
                        withAnimation {
                            isPresent = false
                        }
                    }label: {
                        Text("取消")
                    }
                }
                .padding(.vertical)
                
            }
            .padding(30)
            .foregroundColor(Color("white"))
            .background(.ultraThinMaterial,in: RoundedRectangle(cornerRadius: 20))
            .padding()
        } else {
            // Fallback on earlier versions
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.clear)
                    .blur(radius: 2)
                    .padding(30)
                VStack{
                    HStack{
                        Spacer()
                        Text("添加小标签")
                        Spacer()
                    }
                    Divider()
                    HStack{
                        TextEditor(text: $content)
                    }
                    HStack(spacing:20){
                        Button{
                            withAnimation {
                                guard content != "" else {return}
                                isPresent = false
                                mylistdata.listdata[index].mytag.append(content)
                                mylistdata.dataStore()
                            }
                        }label: {
                            Text("确定")
                        }
                        
                        Button{
                            withAnimation {
                                isPresent = false
                            }
                        }label: {
                            Text("取消")
                        }
                    }
                    .padding(.vertical)
                    
                }
                .foregroundColor(Color("white"))
            }
        }
        
    }
}

