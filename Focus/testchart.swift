

import SwiftUI

@available(iOS 15.0, *)

struct testchart: View {
    @State var text : String = ""
    @State var istyping : Bool = false
   
    init(){
        addobser()
    }
    
    func addobser(){
        let not = NotificationCenter()
        not.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { not in
            withAnimation {
                // 键盘弹出 显示打字中
                istyping = true
            }
        }
        not.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { not in
            withAnimation {
                // 键盘消失 
                istyping = false
            }
        }
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                
                HStack{
                    Image(systemName: "wave.3.right")
                    TextField("", text: $text)
                        .textFieldStyle(.roundedBorder)
                    Image(systemName: "video")
                }
                .padding(.top)
                .padding(.horizontal)
                .background(.gray.opacity(0.2))
            }
            .onChange(of: text, perform: { newValue in
                if newValue != ""{
                    withAnimation {
                        istyping = true
                    }
                }else{
                    withAnimation {
                        istyping = false
                    }
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Image(systemName: "chevron.left")
                }
                ToolbarItem(placement: .principal){
                    if istyping{
                        Text("对方正在输入中")
                            .transition(.opacity)
                            .animation(.default, value: istyping)
                    }else{
                        Text("username")
                            .transition(.opacity)
                            .animation(.default, value: istyping)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Image(systemName: "ellipsis")
                 
                }
            }
        }
    }
}

//struct testchart_Previews: PreviewProvider {
//    static var previews: some View {
//        testchart()
//
//    }
//}
