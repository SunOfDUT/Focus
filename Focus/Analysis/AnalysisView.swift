//
//  AnalysisView.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/29.
//

import SwiftUI

struct AnalysisView: View {
    @State var isPortrait : Bool = true
    @State private var idiom : UIUserInterfaceIdiom =  UIDevice.current.userInterfaceIdiom
    @AppStorage("isOnLearnHelp") var isOnLearnHelp = true
    @EnvironmentObject var MyAllDatas : AllData
    @State var allchoice : [String] = ["单日报告分析","月度报告分析","整体报告分析"]
    @State var mychoice : String = "单日报告分析"
    @State var showMode : Bool = true
    @State var showPickerMode : Bool = false
    @State var showDatePicker : Bool = false
    @State var showice : Bool = false
    @State var selectDate : Date = Date()
    
    var body: some View {
        if #available(iOS 15.0, *){
            ZStack{
                if isPortrait{
                    VStack{
                        if idiom == .phone{
                            HStack{
                                Button{
                                    showMode.toggle()
                                }label:{
                                    Image(systemName: "arrow.2.squarepath")
                                }
                                .foregroundColor(Color("black"))
                                .imageScale(.large)
                                
                                Spacer()
                                
                                Button{
                                    withAnimation {
                                        showDatePicker = true
                                    }
                                }label: {
                                    Text(formatted1(time:selectDate))
                                        .bold()
                                }
                                .foregroundColor(Color("blackpuple"))
                               
                                
                                Spacer()
                                
                               
                                Button{
                                    withAnimation {
                                        showPickerMode = true
                                    }
                                }label:{
                                    Image(systemName: "ellipsis")
                                }
                                .foregroundColor(.black)
                                .imageScale(.large)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                        }else if idiom == .pad{
                            
                            HStack{
                                HStack{
                                    Button{
                                        showMode.toggle()
                                    }label:{
                                        Image(systemName: "arrow.2.squarepath")
                                    }
                                    .foregroundColor(Color("black"))
                                    .imageScale(.large)
                                    
                                   
                                        Picker(selection: $mychoice) {
                                            ForEach(allchoice){ item in
                                                Text(item)
                                                    .tag(item)
                                            }
                                        }label:{
                                            
                                        }
                                        .pickerStyle(.menu)
                                        .accentColor(Color("blackpuple"))
                                    
                           
                                    
                                    Spacer()
                                }
                                .frame(maxWidth:200)
                                Spacer()
                                Text(formatted1(time:selectDate))
                                    .bold()
                                    .foregroundColor(Color("black"))
                                    
                                Spacer()
                                HStack{
                                   
                                   
                                    DatePicker("", selection: $selectDate,displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                       .accentColor(Color("blackpuple"))
                                      
                                }
                                .frame(maxWidth:200)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                        }
                       
                        
                        
                        if isPortrait{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }else{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }
                        
                        Spacer()
                    }
                    Tabbar()
                }else{
                    VStack{
                        if idiom == .phone{
                            
                        }else if idiom == .pad{
                            HStack{
                                HStack{
                                    Button{
                                        showMode.toggle()
                                    }label:{
                                        Image(systemName: "arrow.2.squarepath")
                                    }
                                    .foregroundColor(Color("black"))
                                    .imageScale(.large)
                                    
                                   
                                        Picker(selection: $mychoice) {
                                            ForEach(allchoice){ item in
                                                Text(item)
                                                    .tag(item)
                                            }
                                        }label:{
                                            
                                        }
                                        .pickerStyle(.menu)
                                        .accentColor(Color("blackpuple"))
                                    
                                    
                                    Spacer()
                                }
                                .frame(maxWidth:200)
                                Spacer()
                                Text(formatted1(time:selectDate))
                                    .bold()
                                    .foregroundColor(Color("black"))
                                    
                                Spacer()
                                HStack{
                                   
                                   
                                    DatePicker("", selection: $selectDate,displayedComponents: .date)
                                        .datePickerStyle(.compact)
                                       .accentColor(Color("blackpuple"))
                                      
                                }
                                .frame(maxWidth:200)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                        }
                       
                        
                        if isPortrait{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }else{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }
                        
                        Spacer()
                    }
                    if !(idiom == .phone && !isPortrait){
                        Tabbar()
                    }
                      
                }
               
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { bool in
                guard let scene = UIApplication.shared.windows.first?.windowScene else {return}
                self.isPortrait = scene.interfaceOrientation.isPortrait
                print(isPortrait)
            })
            .sheet(isPresented: $showice, content: {
                Picker(selection: $mychoice) {
                    ForEach(allchoice){ item in
                        Text(item)
                            .tag(item)
                    }
                }label:{
                    
                }
                .pickerStyle(.wheel)
                .accentColor(Color("blackpuple"))
            })
            .SheetBottomView(isPresented: $showDatePicker) {
                
            }content:{
                VStack{
                    Text("挑选日期")
                         .padding()
                    DatePicker("", selection: $selectDate,displayedComponents: .date)
                        .datePickerStyle(.graphical)
                       .accentColor(Color("blackpuple"))
               }
               .background(Color("white"))
            }
            
            .confirmationDialog("", isPresented: $showPickerMode, actions: {
                Button(role:.cancel){
                    
                }label: {
                    Text("取消")
                }
                .foregroundColor(.black)
                
                Button{
                    self.mychoice = "单日报告分析"
                }label: {
                    Text("单日报告分析")
                }
                Button{
                    self.mychoice = "月度报告分析"
                }label: {
                    Text("月度报告分析")
                }
                Button{
                    self.mychoice = "整体报告分析"
                }label: {
                    Text("整体报告分析")
                }
            })
        }else{
            ZStack{
                if isPortrait{
                    VStack{
                        if idiom == .phone{
                            HStack{
                                Button{
                                    showMode.toggle()
                                }label:{
                                    Image(systemName: "arrow.2.squarepath")
                                }
                                .foregroundColor(Color("black"))
                                .imageScale(.large)
                                
                                Spacer()
                                
                                Button{
                                    withAnimation {
                                        showDatePicker = true
                                    }
                                }label: {
                                    Text(formatted1(time:selectDate))
                                        .bold()
                                }
                                .foregroundColor(Color("blackpuple"))
                               
                                
                                Spacer()
                                
                               
                                Button{
                                    withAnimation {
                                        showPickerMode = true
                                    }
                                }label:{
                                    Image(systemName: "ellipsis")
                                }
                                .foregroundColor(.black)
                                .imageScale(.large)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                        }else if idiom == .pad{
                            
                            HStack{
                                HStack{
                                    Button{
                                        showMode.toggle()
                                    }label:{
                                        Image(systemName: "arrow.2.squarepath")
                                    }
                                    .foregroundColor(Color("black"))
                                    .imageScale(.large)
                                    
                                    if #available(iOS 15.0, *) {
                                        Picker(selection: $mychoice) {
                                            ForEach(allchoice){ item in
                                                Text(item)
                                                    .tag(item)
                                            }
                                        }label:{
                                            
                                        }
                                        .pickerStyle(.menu)
                                        .accentColor(Color("blackpuple"))
                                    }else{
                                        Button{
                                            withAnimation {
                                                showice = true
                                            }
                                        }label: {
                                            Text(mychoice)
                                                .foregroundColor(.black)
                                        }
                                    }
                           
                                    
                                    Spacer()
                                }
                                .frame(maxWidth:200)
                                Spacer()
                                Text(formatted1(time:selectDate))
                                    .bold()
                                    .foregroundColor(Color("black"))
                                    
                                Spacer()
                                HStack{
                                   
                                   
                                    DatePicker("", selection: $selectDate,displayedComponents: .date)
                                    .datePickerStyle(.compact)
                                       .accentColor(Color("blackpuple"))
                                      
                                }
                                .frame(maxWidth:200)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                        }
                       
                        
                        if isPortrait{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }else{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }
                        
                        
                       
                        Spacer()
                    }
                    Tabbar()
                }else{
                    VStack{
                        if idiom == .phone{
                            
                        }else if idiom == .pad{
                            
                            HStack{
                                HStack{
                                    Button{
                                        showMode.toggle()
                                    }label:{
                                        Image(systemName: "arrow.2.squarepath")
                                    }
                                    .foregroundColor(Color("black"))
                                    .imageScale(.large)
                                    
                                
                                        Button{
                                            withAnimation {
                                                showice = true
                                            }
                                        }label: {
                                            Text(mychoice)
                                                .foregroundColor(.black)
                                        }
                                    
                                    
                                    Spacer()
                                }
                                .frame(maxWidth:200)
                                Spacer()
                                Text(formatted1(time:selectDate))
                                    .bold()
                                    .foregroundColor(Color("black"))
                                    
                                Spacer()
                                HStack{
                                   
                                   
                                    DatePicker("", selection: $selectDate,displayedComponents: .date)
                                        .datePickerStyle(.compact)
                                       .accentColor(Color("blackpuple"))
                                      
                                }
                                .frame(maxWidth:200)
                            }
                            .padding(.horizontal)
                            .padding(.vertical,10)
                        }
                       
                        
                        
                        if isPortrait{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }else{
                            if isOnLearnHelp{
                                VStack(alignment:.leading){
                                    if showMode{
                                        TextAnalysis(isPortrait: $isPortrait,MyAnalysiser:Analysiser(mode: mychoice, date: selectDate), MainMode: $mychoice)
                                    }else{
                                        GraphicalAnalysis(isPortrait: $isPortrait, MyAnalysiser:Analysiser(mode: mychoice, date: selectDate),MainMode: $mychoice)
                                    }
                                }
                                .foregroundColor(Color("black"))
                            }else{
                                Spacer()
                                Text("请到设置中打开学习描绘功能")
                            }
                        }
                        
                        Spacer()
                    }
                    Tabbar()
                }
               
            }
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { bool in
                guard let scene = UIApplication.shared.windows.first?.windowScene else {return}
                self.isPortrait = scene.interfaceOrientation.isPortrait
                print(isPortrait)
            })
            .SheetBottomView(isPresented: $showice) {
                
            }content:{
                VStack{
                    Picker(selection: $mychoice) {
                        ForEach(allchoice){ item in
                            Text(item)
                                .tag(item)
                        }
                    }label:{
                        
                    }
                    .pickerStyle(.wheel)
                    .accentColor(Color("blackpuple"))
               }
               .background(Color("white"))
            }
            .SheetBottomView(isPresented: $showDatePicker) {
                
            }content:{
                VStack{
                    Text("挑选日期")
                         .padding()
                    DatePicker("", selection: $selectDate,displayedComponents: .date)
                        .datePickerStyle(.graphical)
                       .accentColor(Color("blackpuple"))
               }
               .background(Color("white"))
            }
        }
    
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            AnalysisView()
                .environmentObject(AllData(initAllData()))
                .environmentObject(Model())
                .previewInterfaceOrientation(.portraitUpsideDown)
        } else {
            // Fallback on earlier versions
            AnalysisView()
                .environmentObject(AllData(initAllData()))
                .environmentObject(Model())
        }
    }
}
