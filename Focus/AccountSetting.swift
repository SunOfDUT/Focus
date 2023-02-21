//
//  AccountSetting.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/28.
//

import Parse
import SwiftUI

struct AccountSetting : View{
    @AppStorage("isSign") var isSign = false
    @AppStorage("isOnLearnHelp") var isOnLearnHelp = true
    @AppStorage("cloud") var cloud = true
    @EnvironmentObject var myclient : ClientDatas
    @EnvironmentObject var MyAllData : AllData
    @State var BlendMode = false
    @State var LearningState : [String] = ["高考","研究生考试","普通学习"]
    @State var CountDownState : [String] = ["简约","清新","华丽"]
    @State var LearningMode : String = ""
    @State var CountDownStyle : String = ""
    @Binding var isPresent : Bool
    @State var showalert = false
    @State var username : String = ""
    @State var showImagePicker = false
    @State var imagedata : Data = Data()
    @State var saveresult : Bool = false
    @State var mode : Bool = false
    @Environment(\.presentationMode) var  presentationMode
    
    var body: some View{
        VStack(alignment:.leading){
            HStack{
                Spacer()
                Text("设置")
                Spacer()
            }
            .foregroundColor(Color("black"))
            .padding(.top)
            .background(Color("white"))
            
            List{
                
                
                Section{
                    HStack(alignment:.top){
                        Spacer()
                        VStack{
                            Button{
                                withAnimation {
                                    showImagePicker = true
                                }
                            }label: {
                                PublicURLImageView(imageurl: myclient.client.image, contentmode: true)
                                    .frame(width: 80, height: 80)
                                    .mask(Circle())
                            }
                            
                            Text("\(myclient.client.name)")
                        }
                      
                        Spacer()
                    }
                    
                    HStack(alignment:.center){
                        Text("名称")
                            
                        Spacer()
                        
                        TextField("", text: $myclient.client.name)
                            .accentColor(Color("white"))
                    }
                    
                    HStack(alignment:.center){
                        Text("当前的学习阶段")
                            
                        Spacer()
                        
                        Text(myclient.client.LearningMode)
                        .accentColor(Color("white"))
                    }
                    
                VStack(alignment:.leading){
                     if #available(iOS 15.0, *) {
                         Toggle(isOn: $isOnLearnHelp) {
                             Text(isOnLearnHelp ?  "关闭辅助学习描绘":"开启辅助学习描绘")
                         }
                         .tint(Color("fadegreen"))
                     } else {
                         // Fallback on earlier versions
                         Toggle(isOn: $isOnLearnHelp) {
                             Text(isOnLearnHelp ?  "关闭辅助学习描绘":"开启辅助学习描绘")
                         }
                         .accentColor(Color("fadegreen"))
                     }
                     Text("开启之后,能够为你生成单独的学习报告,以及日绘,月绘")
                         .font(.footnote)
                         .foregroundColor(Color("gray"))
                 }
                    
                    if #available(iOS 15.0, *) {
                       Toggle(isOn: $cloud) {
                           Text("开启云同步")
                       }
                       .tint(Color("fadegreen"))
                    }else{
                       // Fallback on earlier versions
                       Toggle(isOn: $cloud) {
                           Text("开启云同步")
                       }
                       .accentColor(Color("fadegreen"))
                   }
                    
//                    HStack{
//                        Text("倒计时样式风格")
//                        Spacer()
//                        Picker(selection: $CountDownStyle) {
//                            ForEach(CountDownState){ item in
//                                Text(item)
//                                    .tag(item)
//                            }
//                        }label: {
//
//                        }
//                        .accentColor(Color("white"))
//                    }
                    
//                    if #available(iOS 15.0, *) {
//                        Toggle(isOn: $BlendMode) {
//                            Text("极简模式")
//                        }
//                        .tint(Color("yellow"))
//                    } else {
//                        // Fallback on earlier versions
//                        Toggle(isOn: $BlendMode) {
//                            Text("极简模式")
//                        }
//                        .accentColor(Color("yellow"))
//                    }
                }
                .padding(5)
                .foregroundColor(Color("white"))
                .listRowBackground(Color("green"))
                .onChange(of: myclient.client.LearningMode) { newValue in
                    myclient.client.LearningMode = newValue
                    myclient.datastore()
                }
                .onChange(of: cloud) { newValue in
                    if newValue == false{
                        showalert = true
                    }
                }
                .alert(isPresented: $showalert) {
                    Alert(title: Text("提示"), message: Text("关闭云同步后,将不会上传数据到云端"), primaryButton: Alert.Button.destructive(Text("确定")), secondaryButton: Alert.Button.cancel(Text("取消"),action: {
                        withAnimation {
                            cloud = true
                        }
                    }))
                }
                
                Section{
                    Button{
                        withAnimation {
                            isSign = false
                            MyAllData.alldatas = []
                            MyAllData.dataStore()
                        }
                    }label: {
                        HStack{
                            Spacer()
                            Text("注销")
                            Spacer()
                        }
                    }
                }
                .foregroundColor(Color("white"))
                .listRowBackground(Color("green"))
                
                
            }
        }
        .onDisappear(perform: {
            if myclient.client.name != ""{
                myclient.datastore()
                ServerSave(ChangeName: "username", ChangeContent: myclient.client.name)
                print("ok")
            }
        })
        .fullScreenCover(isPresented: $showImagePicker) {
            // ondismiss
            if(!imagedata.isEmpty){
//                Myclientdata.MyClient.clienbakground = backgrounddata
//                Myclientdata.datastore()
                ServerSaveImage(ChangeName: "image", ChangeContent: imagedata)
            }
        }content:{
            PublicImagePicker(completeHandler: { image in
                print(")\(image.count)image为空")
                guard image.first?.imagedata != nil else {
                    
                    return
                }
                self.imagedata = image.first!.imagedata!
            },ChoiceMode: false)
        }
//        .onChange(of: myclient.client.name, perform: { newValue in
//            if newValue != ""{
//                myclient.datastore()
//                ServerSave(ChangeName: "username", ChangeContent: myclient.client.name)
//            }
//        })
        
        .alert(isPresented: $saveresult) {
            Alert.init(title: Text("上传成功!"))
        }
    }
    
    func ServerSave(ChangeName:String,ChangeContent:Any){
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo:myclient.client.objectid)
        query?.findObjectsInBackground{ user, error in
            if(error != nil){
                print("发现错误")
            }else if let user = user{
                user[0][ChangeName] = ChangeContent
                user[0].saveInBackground()
            }
        }
    }
    
    
    func ServerSaveImage(ChangeName:String,ChangeContent:Data){
        let query = PFUser.query()
        query?.whereKey("objectId", equalTo:myclient.client.objectid)
        query?.findObjectsInBackground{ user, error in
            if(error != nil){
                print("发现错误")
            }else if let user = user{
                let imagefile = PFFileObject(name: "image.png", data: ChangeContent)!
                user[0][ChangeName] = imagefile
                user[0].saveInBackground { success, error in
                    self.UpdateClientImage(username: myclient.client.objectid, changename: ChangeName, result: success)
                }
            }
        }
    }
    
    func UpdateClientImage(username:String,changename:String,result:Bool){
        let query = PFUser.query()
        query?.whereKey("objectId", contains: username)
        query?.findObjectsInBackground{ user, error in
            if(error != nil){
                print("发现错误")
            }else if let user = user{
                let newimage = user[0][changename] as! PFFileObject
                let newimageurl = newimage.url!
                myclient.client.image = newimageurl
                self.saveresult = result
                myclient.datastore()
            }
        }
    }
}

struct AccountSetting_preview : PreviewProvider{
    static var previews: some View{
        AccountSetting(isPresent: .constant(false))
            .environmentObject(ClientDatas(initSetting()))
    }
}
