//
//  Extesion.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI

extension View{
    func SheetCenter<Content:View>(isPresent:Binding<Bool>,BackgrounColor: Color,@ViewBuilder content : @escaping ()->Content) -> some View{
        self
            .modifier(SheetCenterViewModifier(isPresent: isPresent, BackgrounColor: BackgrounColor,view: {
                 ShettCenter(content: content)
            }))
    }
}

struct ShettCenter<Content:View> : View{
    var content : Content
    init(@ViewBuilder content : @escaping ()->Content){
        self.content = content()
    }
    var body: some View{
        content
    }
}

struct SheetCenterViewModifier<contents:View> : ViewModifier{
    @State var value : CGFloat = 0
    @Binding var isPresent : Bool
    var view : ()->contents
    var BackgrounColor: Color
    
    init(isPresent:Binding<Bool>,BackgrounColor: Color,view: @escaping ()->contents){
        self._isPresent = isPresent
        self.BackgrounColor = BackgrounColor
        self.view = view
    }
    func body(content: Content) -> some View {
            ZStack{
                content
                
                if isPresent{
                    Color.black.opacity(0.2)
//                        .transition(.opacity)
                        .ignoresSafeArea()
                        .animation(.easeIn, value: self.isPresent)
                        .onTapGesture {
                            withAnimation {
                                self.isPresent = false
                            }
                        }
                    
                    view()
                        .transition(.offset(x: 0, y: UIScreen.main.bounds.height))
                        .animation(.easeIn, value: self.isPresent)
                }
            }
    }
    
}
