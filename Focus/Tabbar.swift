//
//  Tabbar.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/29.
//

import SwiftUI

struct Tabbar: View {
    @EnvironmentObject var  model : Model
    var body: some View {
        VStack{
            Spacer()
            VStack{
                HStack{
                    Group{
                        Spacer()
                        if #available(iOS 15.0, *) {
                            Button{
                                model.myslect = .home
                                withAnimation {
                                    model.select = .home
                                }
                            }label:{
                                Image(systemName:   model.myslect == .home  ? "square.text.square.fill":"square.text.square")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color("green"))
                                    
                            }
                        }else{
                            Button{
                                model.myslect = .home
                                withAnimation {
                                    model.select = .home
                                }
                            }label:{
                                Image(systemName:   model.myslect == .home  ? "doc.plaintext.fill":"doc.plaintext")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color("green"))
                                    
                            }
                        }
                        
                        Spacer()
                        
                        Button{
                           
                        }label:{
                            Image(systemName: "note.text")
                                .font(.system(size: 25))
                                .foregroundColor(Color("green"))
                        }
                        .opacity(0)
                        Spacer()
                    }
                    
                    Group{
                        Spacer()
                        
                        Button{
                           
                        }label:{
                            Image(systemName: "note.text")
                                .font(.system(size: 25))
                               
                        }
                        .opacity(0)
                        
                        Spacer()
                        
                        Button{
                            model.myslect = .analysis
                            withAnimation {
                                model.select = .analysis
                            }
                        }label: {
                            Image(systemName: model.myslect == .analysis ? "wrench.and.screwdriver.fill":"wrench.and.screwdriver")
                                .font(.system(size: 25))
                                .foregroundColor(Color("green"))
                        }
                        Spacer()
                    }
                }
            }
            .padding()
            .padding(.bottom,10)
            .background(Color("white"))
           
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
            .environmentObject(Model())
    }
}
