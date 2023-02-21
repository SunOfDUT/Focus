//
//  SignIn.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/5.
//

import SwiftUI
import Parse
import AuthenticationServices

struct SignInAndUp: View {
    @State var isPortrait : Bool = UIDevice.current.orientation.isPortrait
    @State var username = ""
    @State var password = ""
    @State var isagree = false
    @State var SignUpmode : Bool = false
    @State var showalert = false
    @State var alerttext = ""
    @State var isProgress = false
    @State var UpdateData = false
    @AppStorage("isSign") var isSign = false
    @EnvironmentObject var myclient : ClientDatas
    @EnvironmentObject var MyAllData : AllData
    
    func signin(){
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if error != nil{
                withAnimation {
                    isProgress = false
                }
                showalert = true
                alerttext = "登录错误,请稍后再试"
                username = ""
                password = ""
            }else if user == nil{
                withAnimation {
                    isProgress = false
                }
                showalert = true
                alerttext = "该用户不存在,请重试!"
                username = ""
                password = ""
            }else if user != nil{
                withAnimation {
                    let name = user!.object(forKey: "username") as! String
                    let image = user!.object(forKey: "image") as! PFFileObject
                    var learningmode = user!.object(forKey: "LearningMode") as? String
                    if learningmode == nil{
                        learningmode = "普通模式"
                    }
                    let objectid = user!.objectId!
                    GetData(name: name, image: image.url, learningmode: learningmode!,objectid: objectid)
                    isProgress = false
                    withAnimation(.default.delay(0.5)){
                        isSign = true
                    }
                    
                    username = ""
                    password = ""
                }
            }
        }
    }
    
    
    func GetData(name:String,image:String?,learningmode:String,objectid:String){
        self.myclient.client.name = name
        if image != nil{
            self.myclient.client.image = image!
        }else{
            self.myclient.client.image = "http://43.143.95.199:1337/parse/files/Foci/2798938d8f1d0c517385cb0cc30e5973_av2.JPG"
        }
        self.myclient.client.LearningMode = learningmode
        self.myclient.client.objectid = objectid
        self.myclient.datastore()
        
        let query = PFQuery(className: "AllData")
        query.whereKey("userobjectid", equalTo:objectid)
        query.findObjectsInBackground { object,error in
            if error == nil && object != nil{
                withAnimation {
                    UpdateData = true
                }
                self.MyAllData.alldatas = []
                var allofdata : [MyListData] = []
                for item in object!{
                    let name =  item.object(forKey: "name") as! String
                    let time = item.object(forKey: "time") as! TimeInterval
                    let createtime = item.object(forKey: "crtime") as! Date
                    let endtime = item.object(forKey: "Endtime") as! Date
                    let isFroceStop = item.object(forKey: "isFroceStop") as! Bool
                    let mytag = item.object(forKey: "mytag") as! [String]
                    let resttime = item.object(forKey: "resttime") as! TimeInterval
                    let pausetime = item.object(forKey: "pauseTime") as! [Date]
                    let starttime = item.object(forKey: "startTime") as! [Date]
                    allofdata.append(MyListData(name: name, time: time, createtime: createtime, isFinish: resttime == 0 ? true:false, resttime: resttime, pauseTime: pausetime, startTime: starttime, EndTime: endtime, isFroceStop: isFroceStop, mytag: mytag))
                }
                let dateformatter2 = DateFormatter()
                dateformatter2.dateFormat = "dd"
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "MM"
                for mou in 1..<12{
                    let mounthData = allofdata.filter{Int(dateformatter.string(from: $0.createtime)) == mou}
                    // 一个月的数据
                    if !mounthData.isEmpty{
                        for day in 1..<32{
                            // 找到一个月中的固定一天
                            let todayrestime : [MyListData] = mounthData.filter {Int(dateformatter2.string(from: $0.createtime)) == day}
                            if !todayrestime.isEmpty{
                                self.MyAllData.alldatas.append(alldata(date:todayrestime.first!.createtime, datelist:todayrestime))
                                self.MyAllData.dataStore()
                            }
                        }
                    }
                }
                print(self.MyAllData.alldatas)
            }
        }
    }
    
    func signup(){
        let user = PFUser()
        guard username != "" && password != ""else{
            withAnimation {
                isProgress = false
            }
            showalert = true
            alerttext = "用户名和密码不可为空!"
            username = ""
            password = ""
            return
        }
        user["username"] = username
        user["password"] = password
        user["LearningMode"] = "普通模式"
        user.signUpInBackground { succ, error in
            if error != nil && !succ{
                withAnimation {
                    isProgress = false
                }
                showalert = true
                alerttext = "注册错误,请稍后再试"
                username = ""
                password = ""
            }else{
                withAnimation {
                    isProgress = false
                }
                showalert = true
                alerttext = "注册成功"
                username = ""
                password = ""
            }
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            
            if isPortrait{
                ZStack{
                    if #available(iOS 15.0, *){
                        SignUP
                        SignIn
                    }else{
                        if SignUpmode{
                            SignUP
                                .transition(.offset(x:UIScreen.main.bounds.width, y: 0))
                                .animation(.default, value: SignUpmode)
                        }else{
                            SignIn
                                .transition(.offset(x:-UIScreen.main.bounds.width, y: 0))
                                .animation(.default, value: SignUpmode)
                        }
                    }
                    
                  
                    
                    if isProgress{
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        HStack{
                            if UpdateData{
                                Text("更新数据中....")
                                    .foregroundColor(.white)
                            }
                            ProgressView()
                                .foregroundColor(.white)
                                .scaleEffect(2)
                        }
                       
                        
                       
                    }
                }
            }else{
                ZStack{
                    if #available(iOS 15.0, *){
                        SignUP
                        SignIn
                    }else{
                        if SignUpmode{
                            SignUP
                                .transition(.offset(x:UIScreen.main.bounds.width, y: 0))
                                .animation(.default, value: SignUpmode)
                        }else{
                            SignIn
                                .transition(.offset(x:-UIScreen.main.bounds.width, y: 0))
                                .animation(.default, value: SignUpmode)
                        }
                    }
                  
                    if isProgress{
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                        ProgressView()
                            .foregroundColor(.white)
                            .scaleEffect(2)
                    }
                }
            }
           
            
            HStack{
                Spacer()
            }
           
            Spacer()
        }
        .alert(isPresented: $showalert){
           
            Alert(title: Text(alerttext), message: nil, dismissButton: Alert.Button.default(Text("确定")) {
                if alerttext == "注册成功"{
                    withAnimation {
                        SignUpmode = false
                    }
                }
            })
           
        }
        .background(Color("fadegreen"))
        .ignoresSafeArea()
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification), perform: { bool in
            guard let scene = UIApplication.shared.windows.first?.windowScene else {return}
            self.isPortrait = scene.interfaceOrientation.isPortrait
        })
        
    }
    
    var SignUP : some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white.opacity(0.6))
                .shadow(radius: 20)
                
            VStack(alignment:.leading,spacing: 20){
                  
                Text("注册Log-Study")
                        .font(.largeTitle)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white").opacity(0.5))
                        .shadow(radius:20)
                    HStack{
                        Image(systemName: "person")
                            .font(.title2)
                        TextField("填写用户名",text: $username)
                    }
                    .padding()
                }
                .frame( height: 30)
                .padding(.vertical)
               
               
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white").opacity(0.5))
                        .shadow(radius:20)
                    HStack{
                        Image(systemName: "key")
                            .font(.title2)
                        SecureField("填写密码",text: $password)
                    }
                    .padding()
                }
                .frame( height: 30)
                .padding(.vertical)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white").opacity(0.5))
                        .shadow(radius:20)
                    Button{
                        if username == ""{
                            showalert = true
                            alerttext = "用户名不能为空!"
                            return
                        }else if password == ""{
                            showalert = true
                            alerttext = "密码不能为空!"
                            return
                        }
                        withAnimation {
                            isProgress = true
                            signup()
                        }
                    }label: {
                        HStack{
                            Spacer()
                            Text("注册")
                            Spacer()
                        }
                        .padding()
                    }
                    .foregroundColor(.black)
                }
                .frame( height: 30)
                .padding(.vertical)
               
                Divider()
                HStack{
                    Text("注册完毕?")
                        
                     Button{
                        
                         withAnimation(.spring()){
                             SignUpmode = false
                         }
                     }label: {
                         if #available(iOS 15.0, *){
                             Text("**点击登录**")
                                 .foregroundColor(Color("blackpuple"))
                         }else{
                             Text("点击登录")
                                 .foregroundColor(Color("blackpuple"))
                         }
                        
                     }
                }
                .font(.footnote)
                .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
           
        }
        .frame(width:UIScreen.main.bounds.width - 40,height:400)
        .rotation3DEffect(.degrees(SignUpmode ? 0:180), axis: (x:10, y:0, z: 0))
        .opacity(SignUpmode ? 1:0)
    }
    
    var SignIn : some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white.opacity(0.6))
                .shadow(radius: 20)
                
            VStack(alignment:.leading,spacing: 20){
                VStack(alignment:.leading,spacing: 5){
                    Text("Log-Study")
                            .font(.largeTitle)
                    Text("你的专注助手,帮助你掌控你的专注时间")
                        .foregroundColor(.gray)
                        .font(.body)
                }
                  
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white").opacity(0.5))
                        .shadow(radius:20)
                    HStack{
                        Image(systemName: "person")
                            .font(.title2)
                        TextField("填写用户名",text: $username)
                    }
                    .padding()
                }
                .frame( height: 30)
                .padding(.vertical)
               
               
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white").opacity(0.5))
                        .shadow(radius:20)
                    HStack{
                        Image(systemName: "key")
                            .font(.title2)
                        SecureField("填写密码",text: $password)
                    }
                    .padding()
                }
                .frame( height: 30)
                .padding(.vertical)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("white").opacity(0.5))
                        .shadow(radius:20)
                    
                    Button{
                        if username == ""{
                            showalert = true
                            alerttext = "用户名不能为空!"
                            return
                        }else if password == ""{
                            showalert = true
                            alerttext = "密码不能为空!"
                            return
                        }else if !isagree{
                            showalert = true
                            alerttext = "请同意隐私政策!"
                            return
                        }
                        withAnimation {
                            isagree = true
                            signin()
                        }
                    }label: {
                        HStack{
                            Spacer()
                            Text("登录")
                            Spacer()
                        }
                        .padding()
                    }
                    .foregroundColor(.black)
                }
                .frame( height: 30)
                .padding(.vertical)
                
                
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName,.email]//授权时显示的内容
                } onCompletion: { result in
                    switch result{
                        case .success(let auth):
                            
                            guard isagree else{
                                showalert = true
                                alerttext = "请同意隐私政策!"
                                return
                            }
                            switch auth.credential {
                            case let credential as ASAuthorizationAppleIDCredential:
                                username = credential.user
                                let query = PFUser.query()
                                query?.whereKey("appleid", equalTo: username)
                                    query?.getFirstObjectInBackground(block: { object, error in
                                        if object != nil{
                                            withAnimation {
                                                let name = object!.object(forKey: "username") as! String
                                                let image = object!.object(forKey: "image") as! PFFileObject
                                                var learningmode = object!.object(forKey: "LearningMode") as? String
                                                if learningmode == nil{
                                                    learningmode = "普通模式"
                                                }
                                                let objectid = object!.objectId!
                                                GetData(name: name, image: image.url, learningmode: learningmode!,objectid: objectid)
                                                isProgress = false
                                                withAnimation(.default.delay(0.5)){
                                                    isSign = true
                                                }
                                                username = ""
                                                password = ""
                                            }
                                        }else{
                                            username = credential.user
                                            password = "2222"
                                            signup()
                                            username = credential.user
                                            password = "2222"
                                            signin()
                                        }
                                    })
                               
                            default:
                               print("default")
                            }
                        return
                    case .failure(_):
                        showalert = true
                        alerttext = "登录失败"
                        return
                    }
                }
                .frame(height:60)
                .signInWithAppleButtonStyle(.black)
                
                HStack{
                    Button{
                        withAnimation {
                            isagree.toggle()
                        }
                    }label: {
                        Image(systemName: isagree ? "checkmark.circle.fill":"circle")
                    }
                    if #available(iOS 15.0, *){
                        Text("你已阅读 **[隐私协议](https://privacy.1ts.fun/product/1220905840d85683)** ,并同意我们的协议")
                            .font(.footnote)
                    }else{
                        HStack{
                            Text("你已阅读")
                            Link("隐私协议", destination: URL(string: "https://privacy.1ts.fun/product/1220905840d85683")!)
                                .foregroundColor(Color("blackpuple"))
                            Text(",并同意我们的协议")
                        }
                        .font(.footnote)
                    }
                   
                }
                .foregroundColor(.gray)
                
                Divider()
                
                HStack{
                    Text("还没有账户?")
                        
                     Button{
                         withAnimation(.spring()){
                             SignUpmode = true
                         }
                     }label: {
                         if #available(iOS 15.0, *){
                             Text("**点击注册**")
                                 .foregroundColor(Color("blackpuple"))
                         }else{
                             Text("点击注册")
                                 .foregroundColor(Color("blackpuple"))
                         }
                     }
                }
                .font(.footnote)
                .foregroundColor(.gray)
                
                Spacer()
            }
            .padding()
           
        }
        .frame(width:UIScreen.main.bounds.width - 40,height:400)
        .rotation3DEffect(.degrees(SignUpmode ? 180:0), axis: (x:10, y:0, z: 0))
        .opacity(SignUpmode ? 0:1)
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInAndUp()
    }
}
