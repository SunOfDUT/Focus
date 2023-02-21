//
//  DragSheetView.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/6.
//

import SwiftUI

//view<-->view

extension View{
    func DragOfLeftSheetView<Content>(isPresented:Binding<Bool>,onDismiss:(())? = nil,@ViewBuilder content:@escaping()->Content) -> some View where Content:View{
        self
            .modifier(DragSheetViewModifer(action: onDismiss, isPresented: isPresented, view: {
                DragSheetView(content: content)
            }, isleft: true))
    }
    
    func DragOfRightSheetView<Content>(isPresented:Binding<Bool>,onDismiss:(())? = nil,@ViewBuilder content:@escaping()->Content) -> some View where Content:View{
        self
            .modifier(DragSheetViewModifer(action: onDismiss, isPresented: isPresented, view: {
                DragSheetView(content: content)
            }, isleft: false))
    }
}
struct DragSheetView<Content> : View where Content : View{
    var content : Content
    init(@ViewBuilder content:()->Content){
        self.content = content()
    }
    var body: some View{
        VStack{
            content
        }
    }
}

struct DragSheetViewModifer<contents:View> : ViewModifier{
    var action: (())
    @State var value : CGFloat = 0
    @Binding var isPresented : Bool
    @State var isleft : Bool 
    var view : ()->contents
    
    init(action: (())?,isPresented:Binding<Bool>,view:@escaping ()->contents,isleft:Bool){
            self.action = action ?? print("1")
            self._isPresented = isPresented
            self.view = view
            self.isleft = isleft
    }
    
    func body(content: Content) -> some View {
        // 使用了这样的修饰符后，我们的页面应该是怎么样的
            ZStack{
                content
                
                if isPresented{
                    Color("gray")
                        .animation(.default, value: isPresented)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation{
                                isPresented = false
                                action
                            }
                        }
                    
                    if self.isleft{
                        HStack{
                            view()
                                .offset(x:value)
                                .gesture(
                                    DragGesture(minimumDistance: 30)
                                        .onChanged({ value in
                                            guard value.translation.width < 0 else {return}
                                            withAnimation {
                                                self.value = value.translation.width
                                            }
                                        })
                                        .onEnded({ value in
                                            withAnimation {
                                                if self.value < -100{
                                                    self.isPresented = false
                                                    action
                                                }
                                                self.value = 0
                                            }
                                        })
                                )
                            Spacer()
                        }
                        .animation(.default, value: isPresented)
                        .transition(.offset(x: -UIScreen.main.bounds.width, y: 0))
                        .transition(.opacity)
                    }else{
                        HStack{
                            Spacer()
                            view()
                                .offset(x:value)
                                .gesture(
                                    DragGesture(minimumDistance: 30)
                                        .onChanged({ value in
                                            guard value.translation.width > 0 else {return}
                                            withAnimation {
                                                self.value = value.translation.width
                                            }
                                        })
                                        .onEnded({ value in
                                            
                                            
                                            withAnimation {
                                                if self.value > 100{
                                                    self.isPresented = false
                                                    action
                                                }
                                                self.value = 0
                                            }
                                        })
                                )
                           
                        }
                        .animation(.default, value: isPresented)
                        .transition(.offset(x: UIScreen.main.bounds.width, y: 0))
                        .transition(.opacity)
                    }
                }
                
              
              
            }
            .edgesIgnoringSafeArea(.all)
    }
    
}
