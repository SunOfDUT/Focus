//
//  test16.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/2.
//

import SwiftUI
@available(iOS 15.0, *)
struct test16: View {
    @State var MainMode : String = "报告分析"
    @State var count = 3
    @State var count1 = 3
    var body: some View {
        VStack{
            HStack{
                Button{
                   
                }label:{
                    Image(systemName: "arrow.2.squarepath")
                }
                .foregroundColor(.black)
                .imageScale(.large)
                
                Spacer()
                
                Button{
                    withAnimation {
                       
                    }
                }label: {
                    Text(formatted1(time:Date()))
                        .bold()
                }
                .foregroundColor(Color("blackpuple"))
               
                
                Spacer()
                
               
                Button{
                    withAnimation {
                       
                    }
                }label:{
                    Image(systemName: "ellipsis")
                }
                .foregroundColor(.black)
                .imageScale(.large)
            }
            .padding(.horizontal)
            .padding(.top,10)
            
            
            ScrollView{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.7), radius: 10, x: 0, y: 0)
                    .padding()
                
              
                    VStack(alignment:.leading,spacing: 20){
                        HStack{
                            Text("总时长:")
                           
                        }
                        
                        HStack{
                            Text("专注总时长:")
                          
                                
                        }
                        
                        HStack{
                            Text("放松总时长:")
                           
                              
                        }
                        
                
                        VStack(alignment:.leading,spacing: 15){
                            if self.MainMode != "单日报告分析"{
                                HStack{
                                    Text("专注天数:")
                                  
                                }
                            }
                            
                            HStack{
                                Text("专注任务:")
                                
                            }
                            
                            if self.MainMode == "单日报告分析"{
                                HStack{
                                    Text("专注时间最长:")
                                   
                                }
                                
                                HStack{
                                    Text("放松时间最长:")
                                  
                                }
                            }else{
                                HStack{
                                    Text("专注时间最长:")
                                   
                                }
                                
                                HStack{
                                    Text("放松时间最长:")
                                   
                                }
                            }
                        }
                    }
                    .padding()
                
               
            }
        }
    
        Tabbar()
    }
}
}

//struct test16_Previews: PreviewProvider {
//    static var previews: some View {
//        test16()
//            .environmentObject(Model())
//            .previewInterfaceOrientation(.portrait)
//    }
//}
