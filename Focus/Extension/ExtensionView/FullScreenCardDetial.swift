//
//  FullScreenCardDetial.swift
//  Teachin
//
//  Created by 孙志雄 on 2022/8/7.
//


import SwiftUI

//view<-->view

extension View{
    func FullScreenCard<Content>(isPresented:Binding<Bool>,onDismiss:(())? = nil,@ViewBuilder content:@escaping()->Content) -> some View where Content:View{
        self
            .modifier(FullScrrenViewModifer(action: onDismiss, isPresented: isPresented, view: {
                FullScreenView(content: content)
            }))
    }
}
struct FullScreenView<Content> : View where Content : View{
    var content : Content
    init(@ViewBuilder content:()->Content){
        self.content = content()
    }
    var body: some View{
        VStack{
            // 定义了我们想要的那个视图--> bottonview -->产生联系？？？没有
            content
        }
    }
}

struct FullScrrenViewModifer<contents:View> : ViewModifier{
    var action: (())
    @State var value : CGFloat = 0
    @Binding var isPresented : Bool
    var view : ()->contents
    
    init(action: (())?,isPresented:Binding<Bool>,view:@escaping ()->contents){
            self._isPresented = isPresented
            self.view = view
    }
    
    func body(content: Content) -> some View {
        // 使用了这样的修饰符后，我们的页面应该是怎么样的
            ZStack{
                if isPresented{
                    view()
                        .transition(.move(edge: .bottom))
                        .animation(.default, value: isPresented)
                }else{
                    content
                        .transition(.opacity)
                        .animation(.default, value: isPresented)
                }
            }
            .edgesIgnoringSafeArea(.all)
    }
    
}

//view<-->view

extension View{
    func FullScreenOfLeftCard<Content>(isPresented:Binding<Bool>,onDismiss:(())? = nil,@ViewBuilder content:@escaping()->Content) -> some View where Content:View{
        self
            .modifier(FullScreenOfLeftViewModifer(action: onDismiss, isPresented: isPresented, view: {
                FullScreenOfLeftView(content: content)
            }))
    }
    func FullScreenOfRightCard<Content>(isPresented:Binding<Bool>,onDismiss:(())? = nil,@ViewBuilder content:@escaping()->Content) -> some View where Content:View{
        self
            .modifier(FullScreenOfRightViewModifer(action: onDismiss, isPresented: isPresented, view: {
                FullScreenOfRightView(content: content)
            }))
    }
}
struct FullScreenOfRightView<Content> : View where Content : View{
    var content : Content
    init(@ViewBuilder content:()->Content){
        self.content = content()
    }
    var body: some View{
        VStack{
            // 定义了我们想要的那个视图--> bottonview -->产生联系？？？没有
            content
        }
    }
}

struct FullScreenOfRightViewModifer<contents:View> : ViewModifier{
    var action: (())
    @State var value : CGFloat = 0
    @Binding var isPresented : Bool
    var view : ()->contents
    
    init(action: (())?,isPresented:Binding<Bool>,view:@escaping ()->contents){
            self._isPresented = isPresented
            self.view = view
    }
    
    func body(content: Content) -> some View {
        // 使用了这样的修饰符后，我们的页面应该是怎么样的
            ZStack{
                
                
                if !isPresented ||  value != 0{
                    content
                        .animation(.default, value:isPresented)
                        .offset(x: isPresented ? -UIScreen.main.bounds.width : 0)
                        .offset(x: value)
                        .transition(.opacity)
                }
                
                if isPresented{
                    view()
                        .offset(x:value)
                        .gesture(
                            DragGesture(minimumDistance: 50)
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
                                        }
                                        self.value = 0
                                    }
                                })
                        )
                        .transition(.offset(x:  UIScreen.main.bounds.width, y: 0))
                        .animation(.default, value: isPresented)
                        .transition(.opacity)
                }
            }
            .edgesIgnoringSafeArea(.all)
    }
    
}


struct FullScreenOfLeftView<Content> : View where Content : View{
    var content : Content
    init(@ViewBuilder content:()->Content){
        self.content = content()
    }
    var body: some View{
        VStack{
            // 定义了我们想要的那个视图--> bottonview -->产生联系？？？没有
            content
        }
    }
}

struct FullScreenOfLeftViewModifer<contents:View> : ViewModifier{
    var action: (())
    @State var value : CGFloat = 0
    @Binding var isPresented : Bool
    var view : ()->contents
    
    init(action: (())?,isPresented:Binding<Bool>,view:@escaping ()->contents){
            self._isPresented = isPresented
            self.view = view
    }
    
    func body(content: Content) -> some View {
        // 使用了这样的修饰符后，我们的页面应该是怎么样的
            ZStack{
                
                if isPresented{
                    view()
                        .offset(x:value)
                        .gesture(
                            DragGesture(minimumDistance: 50)
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
                                        }
                                        self.value = 0
                                    }
                                })
                        )
                        .transition(.offset(x:  -UIScreen.main.bounds.width, y: 0))
                        .animation(.default, value: isPresented)
                        .transition(.opacity)
                }
                
                if !isPresented ||  value != 0{
                    content
                        .animation(.default, value: isPresented)
                        .offset(x: isPresented ? UIScreen.main.bounds.width : 0)
                        .offset(x: value)
                        .transition(.opacity)
                }
              
            }
            .edgesIgnoringSafeArea(.all)
    }
}
