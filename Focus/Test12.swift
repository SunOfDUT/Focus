//
//  Test12.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/30.
//

import SwiftUI

//struct Test12: View {
//    @State var text : String = ""
//    var body: some View {
//        VStack{
//            ZStack{
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundColor(Color("deepgreen"))
//                VStack(alignment:.leading,spacing: 20){
//                    Text("学习时序图")
//                    Capsule()
//                        .foregroundColor(.white)
//                        .frame(height: 60)
//                        .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//
//                    HStack(alignment:.top){
//                        VStack{
//                            ZStack{
//                                if #available(iOS 15.0, *) {
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .fill(.ultraThinMaterial)
//                                        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
//                                        .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//                                } else {
//                                    // Fallback on earlier versions
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .foregroundColor(.white)
//                                        .blur(radius: 2)
//                                        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
//                                        .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//                                }
//                                Text("学习效率任务完成度")
//                            }
//                            ZStack{
//                                if #available(iOS 15.0, *) {
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(.ultraThinMaterial)
//                                    .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
//                                    .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//                                }else{
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .foregroundColor(.white)
//                                        .blur(radius: 2)
//                                        .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
//                                        .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//
//                                }
//                                Text("建议")
//                            }
//                        }
//
//                        VStack{
//                            ZStack{
//                                if #available(iOS 15.0, *) {
//                                RoundedRectangle(cornerRadius: 20)
//                                    .fill(.ultraThinMaterial)
//                                    .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
//                                }else{
//
//                                }
//                                HStack{
//                                    VStack(alignment:.leading,spacing: 15){
//                                        HStack{
//                                            VStack(alignment:.leading,spacing: 20){
//                                                HStack{
//                                                    Text("总时长:")
//                                                    Text("18小时")
//                                                        .font(.title)
//                                                }
//
//                                                HStack{
//                                                    Text("专注总时长:")
//                                                    Text("10小时")
//                                                        .font(.title)
//                                                }
//
//                                                HStack{
//                                                    Text("放松总时长:")
//                                                    Text("8小时")
//                                                        .font(.title)
//                                                }
//
//                                            }
//                                            .padding()
//                                            .foregroundColor(.white)
//                                            .background(Color("fadegreen"),in: RoundedRectangle(cornerRadius: 10))
//
//
//                                            VStack(alignment:.leading,spacing: 15){
//                                                Text("专注任务:个")
//                                                Text("专注时间最长:")
//                                                Text("放松时间最长:")
//                                            }
//
//
//                                            Spacer()
//                                        }
//                                        Spacer()
//                                    }
//                                    .padding()
//                                }
//                            }
//                        }
//
//                    }
//
//                    Spacer()
//                }
//                .padding()
//            }
//        }
//        .foregroundColor(.white)
//        .padding()
//    }
//}

//struct Test12_Previews: PreviewProvider {
//    static var previews: some View {
//        Test12()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
