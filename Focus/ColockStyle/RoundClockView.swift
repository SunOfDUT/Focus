//
//  RoundClockView.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/2.
//

import SwiftUI

struct PadRoundClock : View{
     @Binding var isPortrait : Bool 
    @Binding var hour1 : Int
    @Binding var hour2 : Int
    @Binding var min1 : Int
    @Binding var min2 : Int
    @Binding var sec1 : Int
    @Binding var sec2 : Int
    @State var Size : CGSize = CGSize(width: 10, height: 10)
    var body: some View {
           ZStack{
               RoundedRectangle(cornerRadius: 20)
                   .frame(width:Size.width, height: Size.height)
                   .foregroundColor(Color("green"))
                   .shadow(color: Color("black"), radius: 10, x: 0, y: 5)
               
              
               HStack{
                 Text("\(hour1)\(hour2)")
                      .frame(width: Size.width / 3 )

                  Divider()
                      .background(Color("white"))


                  Text("\(min1)\(min2)")
                      .frame(width: Size.width / 3 )


                  Divider()
                      .background(Color("white"))

                  Text("\(sec1)\(sec2)")
                      .frame(width: Size.width / 3 )
              }
               .foregroundColor(Color("white"))
               .font(.system(size: 70))
            }
           .frame(width:Size.width, height: Size.height)
           .onAppear {
               if isPortrait{
                   self.Size = CGSize(width: UIScreen.main.bounds.width - 140, height: UIScreen.main.bounds.height / 3)
               }else{
                   self.Size = CGSize(width: UIScreen.main.bounds.width / 2 + 120 , height: UIScreen.main.bounds.height / 3 + 80)
               }
           }
           .onChange(of: isPortrait) { newValue in
               if newValue{
                   self.Size = CGSize(width: UIScreen.main.bounds.width - 140, height: UIScreen.main.bounds.height / 3)
               }else{
                   self.Size = CGSize(width: UIScreen.main.bounds.width / 2 + 120 , height: UIScreen.main.bounds.height / 3 + 80)
               }
           }
    }
}

struct PhoneRoundClock : View{
    @Binding var isPortrait : Bool
    @Binding var hour1 : Int
    @Binding var hour2 : Int
    @Binding var min1 : Int
    @Binding var min2 : Int
    @Binding var sec1 : Int
    @Binding var sec2 : Int
    @State private var Size : CGSize = CGSize(width: 10, height: 10)


    @State var mode : Int = 0
    var body: some View {
        if isPortrait{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("green"))
                    .shadow(color: .black, radius: 20, x: 0, y: 10)

                HStack{
                   Text("\(hour1)\(hour2)")
                        .frame(width: 100)

                    Divider()
                       

                    Text("\(min1)\(min2)")
                        .frame(width: 100)


                    Divider()
                       

                    Text("\(sec1)\(sec2)")
                        .frame(width: 100)
                }
                .foregroundColor(.white)
                .font(.largeTitle)
             }
            .frame(width: 300, height:200)
        }else{
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color("green"))
                    .shadow(color: .black, radius: 20, x: 0, y: 10)

                HStack{
                    Text("\(hour1)\(hour2)")
                        .frame(width:120)

                    Divider()
                       

                    Text("\(min1)\(min2)")
                        .frame(width:120)


                    Divider()
                       

                    Text("\(sec1)\(sec2)")
                        .frame(width:120)
                }
                .foregroundColor(.white)
                .font(.largeTitle)
             }
            .frame(width: 400, height:200)
        }

    }
}

//struct RoundClockView_Previews: PreviewProvider {
//    static var previews: some View {
//        if #available(iOS 15.0, *) {
//            PhoneRoundClock(isPortrait: .constant(false))
//                .previewInterfaceOrientation(.landscapeLeft)
//        } else {
//            // Fallback on earlier versions
//        }
//    }
//}
