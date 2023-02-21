//
//  SheetBottomView.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/1.
//

import SwiftUI

extension View{
    // 函数作为我们的参数传入
    func SheetBottomView<Content>(isPresented:Binding<Bool>,onDismiss:@escaping ()->Void,@ViewBuilder content:@escaping()->Content) -> some View where Content:View{
        self
            .modifier(BottomViewModifer(action: onDismiss, isPresented: isPresented, view: {
                BottomView(content: content)
            }))
    }
}
struct BottomView<Content> : View where Content : View{
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

struct BottomViewModifer<contents:View> : ViewModifier{
    var action : ()->Void
    @State var value : CGFloat = 0
    @Binding var isPresented : Bool
    var view : ()->contents
    
    init(action : @escaping ()->Void,isPresented:Binding<Bool>,view:@escaping ()->contents){
        self.action = action
            self._isPresented = isPresented
            self.view = view
    }
    
    func body(content: Content) -> some View {
        // 使用了这样的修饰符后，我们的页面应该是怎么样的
            ZStack{
                content
                
                
                if isPresented{
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .animation(.default, value: isPresented)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation {
                                isPresented = false
                                action()
                            }
                        }
                }
                    VStack{
                        Spacer()
                        view()
                            .offset(y:value)
                            .gesture(
                                DragGesture(minimumDistance: 20)
                                    .onChanged({ value in
                                        guard value.translation.height > 0 else {return}
                                        withAnimation {
                                            self.value = value.translation.height
                                        }
                                    })
                                    .onEnded({ value in
                                        if self.value > 120{
                                            withAnimation{
                                                isPresented = false
                                                action()
                                            }
                                        }
                                        withAnimation{
                                            self.value = 0
                                        }
                                    })
                            )
                           
//
                    }
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(x: 0, y: isPresented ? 0:UIScreen.main.bounds.height+100)

            }
    }
    
}
