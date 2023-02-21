//
//  CreateList.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI

struct CreateList: View {
    @EnvironmentObject var mylistdata : ToDoListData
    @EnvironmentObject var  model : Model
    @Binding var   showDetial : Bool
    @Binding var isPrsent : Bool
    @State var animations : [Bool] = Array(repeating: false, count: 2)
    @State var todothings : String = ""
    @State var hour : Int = 0
    @State var minutes : Int = 30
    
    func GetTimeInterval(hour:Int,min:Int) -> TimeInterval{
        var output : TimeInterval
        let hour = Double(hour * 3600)
        let min = Double(min * 60)
        output = hour + min
        print(output)
        return output
    }
    
    var body: some View {
        ZStack{
           
        VStack{
            Text("创建事项")
                .font(.system(size: 25))
                .bold()
                .opacity(animations[0] ?  1:0)
            VStack(alignment:.leading){
            Divider()
            Text("填写事项(可选)")
                .font(.system(size: 25))
                .bold()
                .opacity(animations[0] ?  1:0)
                
            TextField("起个名字吧..", text: $todothings)
                    .opacity(animations[0] ?  1:0)
                .padding(.bottom)
            
            Divider()
                
            VStack(alignment: .leading, spacing: 18){
            Text("选择专注时长")
                .font(.system(size: 25))
                .bold()
                .opacity(animations[1] ?  1:0)
               
                HStack{
                    Text("\(hour) 小时")
                        .font(.title2)
                        .transition(.opacity)
                        .animation(.default, value: self.animations[1])
                    
                    Stepper(""){
                        guard hour < 6 else {return}
                        hour += 1
                    }onDecrement: {
                        guard hour > 0 else {return}
                        hour -= 1
                    }onEditingChanged: { ischange in
                        
                    }
                }
                .opacity(animations[1] ?  1:0)
                    
                
                HStack{
                    Text("\(minutes) 分钟")
                        .font(.title2)
                        
                   
                    Stepper(""){
                        guard hour < 6 else {return}
                        guard minutes < 55 else {
                            hour += 1
                            minutes = 0
                            return
                        }
                        minutes += 5
                    }onDecrement: {
                        guard minutes > 5 else {return}
                        minutes -= 5
                    }onEditingChanged: { ischange in
                        
                    }
                }
                    .opacity(animations[1] ?  1:0)
                }
              
            }
            .padding(.bottom)
            
            HStack(spacing:26){
                Button{
                    withAnimation {
                        isPrsent = false
                        mylistdata.listdata.append(MyListData(name: self.todothings, time: GetTimeInterval(hour: hour, min: minutes), createtime: Date(), isFinish: false, resttime: GetTimeInterval(hour: hour, min: minutes), pauseTime: [], startTime: [], EndTime: Date(timeInterval: GetTimeInterval(hour: hour, min: minutes), since: Date()), isFroceStop: false, mytag: []))
                        mylistdata.dataStore()
                        model.index = mylistdata.listdata.endIndex - 1
                        showDetial = true
                    }
                }label: {
                    if #available(iOS 15.0, *) {
                        Image(systemName: "checkmark")
                            .font(.title3)
                            .foregroundColor(Color("white"))
                            .padding()
                            .background(Color("green"),in: Circle())
                           
                    } else {
                        // Fallback on earlier versions
                        ZStack{
                            Circle()
                                .foregroundColor(Color("green"))
                                
                            Image(systemName: "checkmark")
                                .font(.title3)
                                .foregroundColor(Color("white"))
                        }
                        .frame(width: 40, height: 40)
                            
                    }
                }
            }
            .padding(.top,10)
        }
        .padding()
    }
    .onAppear {
        withAnimation(.easeInOut.delay(0.1)){
            animations[0] = true
        }
        withAnimation(.easeInOut.delay(0.2)){
            animations[1] = true
        }
    }
    .onDisappear(perform: {
        withAnimation(.easeInOut.delay(0.15)){
            animations[0] = false
        }
        withAnimation(.easeInOut.delay(0.2)){
            animations[1] = false
        }
    })
}
}

struct CreateList_Previews: PreviewProvider {
    static var previews: some View {
        CreateList(showDetial:.constant(false), isPrsent: .constant(false))
            .environmentObject(ToDoListData(initListData()))
            .environmentObject(Model())
    }
}
