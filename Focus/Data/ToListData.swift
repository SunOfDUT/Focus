//
//  ToListData.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/27.
//

import SwiftUI
import Parse
func initListData() -> [MyListData] {
    var output = [MyListData]()
    if let data = UserDefaults.standard.object(forKey: "listdata") as? Data{
        let datastore = try! JSONDecoder().decode([MyListData].self, from: data)
        output = datastore
    }
    return output
}

class ToDoListData : ObservableObject{
    @Published var listdata : [MyListData]
    @AppStorage("cloud") var cloud = true
    @ObservedObject var MyAllData : AllData = AllData(initAllData())
    @ObservedObject var Setdata : ClientDatas = ClientDatas(initSetting())
    
    init(_ listdata : [MyListData]){
        self.listdata = listdata
    }
    
    func Gettime(date:Date) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let lastdate = Int(dateFormatter.string(from:date))!
        let currentdate = Int(dateFormatter.string(from:Date()))!
        if lastdate < currentdate{
            return true
        }else if currentdate < lastdate{
            //月
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM"
            let lastMonth = Int(dateFormatter.string(from:date))!
            let currentMonth  = Int(dateFormatter.string(from:Date()))!
            if currentMonth > lastMonth{
                return true
            }
        }
        return false
    }
    
    func Check(){
        guard self.listdata != [] else {return}
        if Gettime(date: self.listdata.last!.createtime){
           MyAllData.alldatas.append(alldata(date:self.listdata.last!.createtime, datelist: self.listdata))
           MyAllData.dataStore()
            if cloud{
                for i in listdata{
                    UpLoad(data: i)
                }
            }
           
           self.listdata = []
           self.dataStore()
        }
    }
    
    func UpLoad(data:MyListData){
        let object = PFObject(className:"AllData")
        object["name"] = data.name
        object["time"] = Double(data.time)
        object["crtime"] = data.createtime
        object["Endtime"] = data.EndTime
        object["isFroceStop"] = data.isFroceStop
        object["mytag"] = data.mytag
        object["resttime"] = data.resttime
        object["pauseTime"] = data.pauseTime
        object["startTime"] = data.startTime
        object["userobjectid"] =  Setdata.client.objectid
        object.saveInBackground()
    }
    
    func getit(date:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let date = dateFormatter.date(from: date)!
        print(date)
        return date
    }
    
    func dataStore(){
        let datastore = try! JSONEncoder().encode(self.listdata)
        UserDefaults.standard.set(datastore, forKey: "listdata")
    }
}

struct MyListData : Identifiable,Codable,Equatable{
    var id = UUID()
    var name : String
    var time : TimeInterval
    var createtime : Date
    var isFinish : Bool
    var resttime : TimeInterval
    var pauseTime : [Date]
    var startTime : [Date]
    var EndTime : Date
    var isFroceStop : Bool
    var mytag : [String]
}
struct mytag : Identifiable,Codable,Equatable{
    var id = UUID()
    var title : String
    var content : String
}
