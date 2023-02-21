//
//  MainView.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/29.

import SwiftUI

struct MainView: View {
    @AppStorage("isSign") var isSign = false
    @EnvironmentObject var  model : Model
    @EnvironmentObject var mylistdata : ToDoListData
    var body: some View {
        if !isSign{
            SignInAndUp()
                .transition(.opacity)
        }else{
            Group{
                switch model.myslect{
                    case .home:
                        ContentView()
                            .onAppear {
                                print("1check")
                                mylistdata.Check()
                            }
                    case .analysis:
                        AnalysisView()
                            .onAppear {
                                print("2check")
                                mylistdata.Check()
                            }
                }
            }
            .transition(.opacity)
        }
    }
}
