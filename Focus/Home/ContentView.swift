//
//  ContentView.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI
import Parse

struct ContentView: View {
    @EnvironmentObject var MyAllData : AllData
    @State var isPortrait : Bool = UIDevice.current.orientation.isPortrait
    @State private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    @State var LearningState : [String] = ["高考","研究生考试","普通模式"]
    @EnvironmentObject var myclient : ClientDatas
    @EnvironmentObject var mylistdata : ToDoListData
    @EnvironmentObject var  model : Model
    @State var slectdate = Date()
    @State var showPlus : Bool = false
    @State var showAlert : Bool = false
    @State var showAlert2 : Bool = false
    @State var timer : Timer?
    @State var showDetial : Bool = false
    @State var showAccount : Bool = false
    @State var showChocie : Bool = false
    
    
    var body: some View {
        if #available(iOS 15.0, *) {
            ZStack{
                    VStack(alignment:.leading){
                        HStack{
                            Button{
                                withAnimation {
                                    showAccount = true
                                }
                            }label:{
                                Image(systemName: "person")
                            }
                            .foregroundColor(Color("black"))
                            
                            Spacer()
                            
                            
                                Picker(selection: $myclient.client.LearningMode) {
                                    ForEach(LearningState){ item in
                                        Text(item)
                                            .tag(item)
                                    }
                                }label: {
                                    
                                }
                                .pickerStyle(.menu)
                                .accentColor(Color("blackpuple"))
                          
                             
                            
                            
                           
                            
                            Spacer()
                            
                        }
                        
                        Divider()
                        
                        switch myclient.client.LearningMode{
                            case "高考":
                                Text("距离高考还有\(GetTime3(createtime: Date(), EndTime: Date().CollageExam))")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(Color("black"))
                                    
                            case "研究生考试":
                                Text("距离研究生考试还有\(GetTime3(createtime: Date(), EndTime: Date().graduateExam))")
                                    .foregroundColor(Color("black"))
                                    .font(.largeTitle)
                                    .bold()
                                
                            default:
                                Text("欢迎来到Log-Study")
                                    .foregroundColor(Color("black"))
                                    .font(.largeTitle)
                                    .bold()
                        }
                        
                        ScrollView(showsIndicators:false){
                            ForEach(Array(mylistdata.listdata.enumerated()),id: \.offset){ index,item in
                                Button{
                                    withAnimation {
                                        showDetial = true
                                        model.index = index
                                    }
                                }label: {
                                    SingleList(index: index)
                                        .foregroundColor(Color("black"))
                                        .transition(.move(edge: .trailing))
                                        .animation(.default,value:mylistdata.listdata)
                                }
                                .frame(height:50)
                                Divider()
                            }
                            Color.clear.frame(height: 60)
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(Color("gray"))
           
                    .fullScreenCover(isPresented: $showDetial, content: {
                       
                        if !mylistdata.listdata[model.index].isFinish{
                            PadListDetial(index: model.index, show: $showDetial)
                        }else{
                            Finish(index: model.index, show: $showDetial)
                        }
                    })
                    .onChange(of: myclient.client.LearningMode, perform: { newValue in
                        myclient.client.LearningMode = newValue
                        myclient.datastore()
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("请完成上一个计时!"),
                           message: Text("")
                        )
                   }
                    .sheet(isPresented: $showAccount, content: {
                        AccountSetting(isPresent: $showAccount)
                    })
                    .sheet(isPresented: $showChocie) {
                        Picker(selection: $myclient.client.LearningMode) {
                            ForEach(LearningState){ item in
                                Text(item)
                                    .tag(item)
                            }
                        }label: {
                            
                        }
                        .pickerStyle(.wheel)
                        .accentColor(Color("blackpuple"))
                    }
            
                
                Tabbar()
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            withAnimation {
                                if mylistdata.listdata.last?.isFinish == true || mylistdata.listdata.isEmpty{
                                    showPlus = true
                                }else{
                                    showAlert = true
                                }
                            }
                        }label: {
                           
                                Image(systemName: "plus")
                                    .scaleEffect(1.5)
                                    .foregroundColor(Color("white"))
                                    .frame(width:70, height: 70)
                                    .background(Color("green"),in: Circle())
                                    .shadow(radius: 12)
                                
                        }
                    }
                }
                .padding(.bottom,idiom == .pad ? 90:80)
                .padding(.trailing,idiom == .pad ? 40:20)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { bool in
                guard let scene = UIApplication.shared.windows.first?.windowScene else {return}
                self.isPortrait = scene.interfaceOrientation.isPortrait
            })
            .SheetCenter(isPresent: $showPlus, BackgrounColor: .black, content: {
                if idiom == .pad{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("fadegreen"))
                            .shadow(radius: 12)
                        CreateList(showDetial: $showDetial, isPrsent: $showPlus)
                    }
                    .frame(width: 500, height: 500)
                    .zIndex(1)
                }else if idiom == .phone{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("fadegreen"))
                            .shadow(radius: 12)
                        CreateList(showDetial: $showDetial, isPrsent: $showPlus)
                           
                    }
                    .frame(width:UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 2)
                    .zIndex(99)
                }
              
            })
        }else{
            ZStack{
                    VStack(alignment:.leading){
                        HStack{
                            Button{
                                withAnimation {
                                    showAccount = true
                                }
                            }label:{
                                Image(systemName: "person")
                            }
                            .foregroundColor(Color("black"))
                            
                            Spacer()
                            
                            
                            Button{
                                withAnimation {
                                    showChocie = true
                                }
                            }label: {
                                Text("\(myclient.client.LearningMode)")
                                    .foregroundColor(.black)
                            }
                            Spacer()
                            
//                            Button{
//                                withAnimation {
//                                    showPlus = true
//                                }
//                            }label:{
//                                Image(systemName: "plus")
//                            }
//                            .foregroundColor(Color("black"))
                        }
                        .padding(.top)
                        
                        Divider()
                        
                        
                        
                        switch myclient.client.LearningMode{
                            case "高考":
                                Text("距离高考还有\(GetTime3(createtime: Date(), EndTime: Date().CollageExam))")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(Color("black"))
                                    
                            case "研究生考试":
                                Text("距离研究生考试还有\(GetTime3(createtime: Date(), EndTime: Date().graduateExam))")
                                    .foregroundColor(Color("black"))
                                    .font(.largeTitle)
                                    .bold()
                                
                            default:
                                Text("欢迎来到Log-Study")
                                    .foregroundColor(Color("black"))
                                    .font(.largeTitle)
                                    .bold()
                        }
                        
                        ScrollView(showsIndicators:false){
                            ForEach(Array(mylistdata.listdata.enumerated()),id: \.offset){ index,item in
                                Button{
                                    withAnimation {
                                        showDetial = true
                                        model.index = index
                                    }
                                }label: {
                                    SingleList(index: index)
                                        .foregroundColor(Color("black"))
                                        .transition(.move(edge: .trailing))
                                        .animation(.default,value:mylistdata.listdata)
                                }
                                .frame(height:50)
                                Divider()
                            }
                            Color.clear.frame(height: 60)
                        }
                    }
                    .padding(.horizontal)
                    .foregroundColor(Color("gray"))
                    .onChange(of: myclient.client.LearningMode, perform: { newValue in
                        myclient.client.LearningMode = newValue
                        myclient.datastore()
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("请完成上一个计时!"),
                           message: Text("")
                        )
                   }
                    .sheet(isPresented: $showAccount, content: {
                        AccountSetting(isPresent: $showAccount)
                    })
                    .sheet(isPresented: $showChocie) {
                        Picker(selection: $myclient.client.LearningMode) {
                            ForEach(LearningState){ item in
                                Text(item)
                                    .tag(item)
                            }
                        }label: {
                            
                        }
                        .pickerStyle(.wheel)
                        .accentColor(Color("blackpuple"))
                    }
                
            
               
                Tabbar()
                
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button{
                            withAnimation {
                                if mylistdata.listdata.last?.isFinish == true || mylistdata.listdata.isEmpty{
                                    showPlus = true
                                }else{
                                    showAlert = true
                                }
                            }
                        }label: {
                                ZStack{
                                    Circle()
                                        .foregroundColor(Color("green"))
                                        .shadow(radius: 12)
                                    Image(systemName: "plus")
                                        .scaleEffect(1.5)
                                        .foregroundColor(Color("white"))
                                }
                                .frame(width:70, height: 70)
                            }
                    }
                }
                .padding(.bottom,UIScreen.main.bounds.height)
                .padding(.trailing,40)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { bool in
                guard let scene = UIApplication.shared.windows.first?.windowScene else {return}
                self.isPortrait = scene.interfaceOrientation.isPortrait
            })
            .FullScreenCard(isPresented: $showDetial, content: {
                if !mylistdata.listdata[model.index].isFinish{
                    PadListDetial(index: model.index, show: $showDetial)
                }else{
                    Finish(index: model.index, show: $showDetial)
                }
            })
            .SheetCenter(isPresent: $showPlus, BackgrounColor: .black, content: {
                if idiom == .pad{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("fadegreen"))
                            .shadow(radius: 12)
                        CreateList(showDetial: $showDetial, isPrsent: $showPlus)
                    }
                    .frame(width: 500, height: 500)
                }else if idiom == .phone{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("fadegreen"))
                            .shadow(radius: 12)
                        CreateList(showDetial: $showDetial, isPrsent: $showPlus)
                    }
                    .frame(width:UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2)
                }
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
            //            .previewInterfaceOrientation(.portraitUpsideDown)
                .environmentObject(ToDoListData(initListData()))
                .environmentObject(Model())
                .environmentObject(ClientDatas(initSetting()))
                .environmentObject(AllData(initAllData()))
                .previewInterfaceOrientation(.portrait)
        } else {
            // Fallback on earlier versions
        }
    }
}
