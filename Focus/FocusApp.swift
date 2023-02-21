//
//  FocusApp.swift
//  Focus
//  Created by 孙志雄 on 2022/8/27.

import SwiftUI
import Parse

@main
struct FocusApp: App {
    @ObservedObject var myToDoListData : ToDoListData = ToDoListData(initListData())
    @ObservedObject var MyAllData : AllData = AllData(initAllData())
    @ObservedObject var Setdata : ClientDatas = ClientDatas(initSetting())
    init(){
        let parseconfig = ParseClientConfiguration {
            $0.applicationId = "Foci"
            $0.clientKey = "Foci"
            $0.server = "http:/43.143.95.199:1337/parse"
        }
        Parse.initialize(with: parseconfig)
        withAnimation{
            myToDoListData.Check()
        }
    }
    
    var body: some Scene {
        WindowGroup {
          MainView()
                .environmentObject(ToDoListData(initListData()))
                .environmentObject(Model())
                .environmentObject(ClientDatas(initSetting()))
                .environmentObject(AllData(initAllData()))
        }
    }
}
