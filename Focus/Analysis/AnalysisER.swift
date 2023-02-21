//
//  AnalysisER.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/1.
//

import SwiftUI

class Analysiser : ObservableObject{
    @Published var alltime : [Double]
    @Published var focustime : [timeDate]
    @Published var resttime : [timeDate]
    @Published var anslysisData : AnysisData = AnysisData(count: 1, AdvanceAllTime: 1, ForceStop: 1, tag: [])
    @Published var DateCount : Int = 0
    @Published var RestDistribute : DistributeData
    @Published var FocusDistribute : DistributeData
    @Published var RestCount : DistributeData
    @Published var TaskCount : DistributeData
    @ObservedObject var MyAllData : AllData = AllData(initAllData())
    @ObservedObject var mylistdata : ToDoListData = ToDoListData(initListData())
    
    init(mode:String,date:Date){
        self.alltime = []
        self.focustime = []
        self.resttime = []
        self.RestDistribute = DistributeData(day: [], value: [])
        self.FocusDistribute = DistributeData(day: [], value: [])
        self.TaskCount = DistributeData(day: [], value: [])
        self.RestCount = DistributeData(day: [], value: [])
        self.anslysisData = AnysisData(count: 0,AdvanceAllTime: 0,ForceStop: 0, tag: [])
        if mode == "单日报告分析"{
            self.GetAllData(date: date)
        }else if mode == "月度报告分析"{
            self.GetAllMonth(date: date)
        }else if mode == "整体报告分析"{
            self.GetAll()
        }
        print("MyAllData\(MyAllData.alldatas)")
        print("RestDistribute\(RestDistribute)")
        print("FocusDistribute\(FocusDistribute)")
    }
    
    
    func Getstandarddata(data:DistributeData)->[(String,Double)]{
        var datas : [(String,Double)] = []
        for i in 0..<data.value.count{
            guard i < data.day.count else {break}
            datas.append((data.day[i],data.value[i] / 60))
        }
        return datas
    }
    
    func GetAllFocusDestribute(){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM"
        for i in 1..<12{
            let ThisMounthrestime : [timeDate] = self.focustime.filter {Int(dateformatter.string(from: $0.starttime)) == i}
            // 本月的
            if !ThisMounthrestime.isEmpty{
                self.FocusDistribute.day.append("\(dateformatter.string(from: ThisMounthrestime.first!.starttime))月")
                self.FocusDistribute.value.append(SumTime(time: GetValue(time: ThisMounthrestime)))
            }
        }
    }
    
    func GetFocusDestribute(mounth:String){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM"
        let mounthresttime = self.focustime.filter {dateformatter.string(from: $0.starttime) == mounth}
        let dateformatter2 = DateFormatter()
        dateformatter2.dateFormat = "dd"
        for i in 1..<32{
            let todayrestime : [timeDate] = mounthresttime.filter {Int(dateformatter2.string(from: $0.starttime)) == i}
            // 本天的
            if !todayrestime.isEmpty{
                self.FocusDistribute.day.append("\(dateformatter2.string(from: todayrestime.first!.starttime))日")
                self.FocusDistribute.value.append(SumTime(time: GetValue(time: todayrestime)))
            }
        }
    }
    
    func GetFoucusDayDestribute(day:String){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd"
        let Dayresttime = self.focustime.filter {dateformatter.string(from: $0.starttime) == day}
        let dateformatter2 = DateFormatter()
        dateformatter2.dateFormat = "HH" // hour
        var time : [String] = []
        for i in Dayresttime{
            if !time.contains(dateformatter2.string(from: i.starttime)){
                time.append(dateformatter2.string(from: i.starttime))
            }
        }
        // 获得每一个小时的resttime
        // 制作多种的
        for i in time{
            let hourresttime = focustime.filter{dateformatter2.string(from: $0.starttime) == i}
            let allhourusum = SumTime(time: GetValue(time: hourresttime))
            self.FocusDistribute.day.append("\(i)时")
            self.FocusDistribute.value.append(allhourusum / 60)
        }
    }
    
    func GetRestDayDestribute(day:String){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd"
        let Dayresttime = self.resttime.filter {dateformatter.string(from: $0.starttime) == day}
        let dateformatter2 = DateFormatter()
        dateformatter2.dateFormat = "HH" // hour
        var time : [String] = []
        for i in Dayresttime{
            if !time.contains(dateformatter2.string(from: i.starttime)){
                time.append(dateformatter2.string(from: i.starttime))
            }
        }
        // 获得每一个小时的resttime
        // 制作多种的
        for i in time{
            let hourresttime = resttime.filter{dateformatter2.string(from: $0.starttime) == i}
            let allhourusum = SumTime(time: GetValue(time: hourresttime))
            self.RestDistribute.day.append("\(i)时")
            self.RestDistribute.value.append(allhourusum / 60)
        }
    }
    
    func GetAllRestDestribute(){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM"
        for i in 1..<12{
            let ThisMounthrestime : [timeDate] = self.resttime.filter {Int(dateformatter.string(from: $0.starttime)) == i}
            // 本月的
            if !ThisMounthrestime.isEmpty{
                self.RestDistribute.day.append("\(dateformatter.string(from: ThisMounthrestime.first!.starttime))月")
                self.RestDistribute.value.append(SumTime(time: GetValue(time: ThisMounthrestime)))
            }
        }
    }
    
    func GetRestDestribute(mounth:String){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM"
        let mounthresttime = self.resttime.filter {dateformatter.string(from: $0.starttime) == mounth}
        let dateformatter2 = DateFormatter()
        dateformatter2.dateFormat = "dd"
        for i in 1..<32{
            let todayrestime : [timeDate] = mounthresttime.filter {Int(dateformatter2.string(from: $0.starttime)) == i}
            // 本天的
            if !todayrestime.isEmpty{
            self.RestDistribute.day.append("\(dateformatter2.string(from: todayrestime.first!.starttime))日")
            self.RestDistribute.value.append(SumTime(time: GetValue(time: todayrestime)))
            }
        }
       
    }
    
    func GetAll(){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM"
        var DayDate : [alldata] = []
        for i in MyAllData.alldatas{
            DayDate.append(i)
        }
        guard DayDate != [] else {return}
        DateCount = DayDate.count
        for item in DayDate{
            self.anslysisData.count += item.datelist.count
            // 获得一个月的任务数量
            for i in item.datelist{
                self.anslysisData.AdvanceAllTime += i.time
                self.anslysisData.tag.append(contentsOf: i.mytag)
                GetItemData(item: i)
                if i.isFroceStop{
                    self.anslysisData.ForceStop += 1
                }
            }
        }
        GetAllRestDestribute()
        GetAllFocusDestribute()
    }
    
    func GetAllMonth(date:Date){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd"
        var DayDate : [alldata] = []
        for i in MyAllData.alldatas{
            if Int(formatter.string(from: i.date)) == Int(formatter.string(from: date)){
                DayDate.append(i)
            }
        }
        DateCount = DayDate.count
        guard DayDate != [] else {return}
        // 一月所有的任务数
        for item in DayDate{
            // 获得每一天的任务数量
            self.anslysisData.count += item.datelist.count
            self.TaskCount.value.append(Double(item.datelist.count))
            self.TaskCount.day.append("\(formatter2.string(from: item.date))日")
            var dayrestcount = 0
            for i in item.datelist{
                dayrestcount += i.pauseTime.count
                self.anslysisData.AdvanceAllTime += i.time
                self.anslysisData.tag.append(contentsOf: i.mytag)
                GetItemData(item: i)
                if i.isFroceStop{
                    self.anslysisData.ForceStop += 1
                }
            }
            self.RestCount.day.append("\(formatter2.string(from: item.date))日")
            self.RestCount.value.append(Double(dayrestcount))
        }
        GetRestDestribute(mounth: formatter.string(from: date))
        GetFocusDestribute(mounth: formatter.string(from: date))
    }
    
    func GetAllData(date:Date){
        // 单天
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        var DayDate : [MyListData] = []
        if Int(formatter.string(from: date)) == Int(formatter.string(from: Date())){
            DayDate =  mylistdata.listdata
        }else{
            for i in MyAllData.alldatas{
                if Int(formatter.string(from: i.date)) == Int(formatter.string(from: date)){
                    DayDate.append(contentsOf: i.datelist)
                }
            }
        }
        guard DayDate != [] else {return}
        // 一天所有的任务数
        self.anslysisData.count = DayDate.count
        for i in DayDate{
            self.anslysisData.AdvanceAllTime += i.time
            self.anslysisData.tag.append(contentsOf: i.mytag)
            GetItemData(item: i)
            if i.isFroceStop{
                self.anslysisData.ForceStop += 1
            }
        }
        GetFoucusDayDestribute(day:formatter.string(from:date))
        GetRestDayDestribute(day:formatter.string(from:date))
    }
    
    func GetItemData(item:MyListData){
        let count = item.pauseTime.count
        let endtime =  item.EndTime
        if count == 1{
            let distance = item.pauseTime[0].distance(to: item.createtime)
            self.focustime.append(timeDate(value: abs(distance), starttime: item.createtime))
            self.alltime.append(abs(distance))
            
            if item.startTime.count >= 1{
                let distance2 = item.startTime[0].distance(to:item.pauseTime[0])
                self.resttime.append(timeDate(value: abs(distance2), starttime: item.pauseTime[0]))
                self.alltime.append(abs(distance2))
                
                let enddistance = endtime.distance(to: item.startTime[0])
                self.focustime.append(timeDate(value: abs(enddistance), starttime: item.startTime[0]))
                self.alltime.append(abs(enddistance))
            }else{
                let enddistance = endtime.distance(to: item.pauseTime[0])
                self.focustime.append(timeDate(value: abs(enddistance), starttime: item.pauseTime[0]))
                self.alltime.append(abs(enddistance))
            }
        }else{
            for i in 0..<count{
                if i == 0{
                    let distance = item.pauseTime[i].distance(to: item.createtime)
                    self.focustime.append(timeDate(value: abs(distance), starttime: item.createtime))
                    self.alltime.append(abs(distance))
                    
                    if item.startTime.count >= i+1{
                        let distance2 = item.startTime[i].distance(to: item.pauseTime[i])
                        self.resttime.append(timeDate(value: abs(distance2), starttime: item.pauseTime[i]))
                        self.alltime.append(abs(distance2))
                    }
                }else if i == count-1{
                    let distance = item.pauseTime[i].distance(to: item.startTime[i-1])
                    self.focustime.append(timeDate(value: abs(distance), starttime: item.startTime[i-1]))
                    self.alltime.append(abs(distance))
                    
                    if item.startTime.count >= i+1{
                        let distance2 = item.startTime[i].distance(to: item.pauseTime[i])
                        self.resttime.append(timeDate(value: abs(distance2), starttime: item.pauseTime[i]))
                        self.alltime.append(abs(distance2))
                        
                        let distanceend = item.startTime[i].distance(to: endtime)
                        self.focustime.append(timeDate(value: abs(distanceend), starttime: endtime))
                        self.alltime.append(abs(distanceend))
                        
                    }else{
                        let distanceend = item.pauseTime[i].distance(to: endtime)
                        self.focustime.append(timeDate(value: abs(distanceend), starttime: endtime))
                        self.alltime.append(abs(distanceend))
                    }
                }else{
                    let distance = item.pauseTime[i].distance(to: item.startTime[i-1])
                    self.focustime.append(timeDate(value: abs(distance), starttime: item.startTime[i-1]))
                    self.alltime.append(abs(distance))
                    
                    if item.startTime.count >= i+1{
                        let distance2 = item.startTime[i].distance(to: item.pauseTime[i])
                        self.resttime.append(timeDate(value: abs(distance2), starttime: item.pauseTime[i]))
                        self.alltime.append(abs(distance2))
                    }
                }
            }
        }
        if count == 0{
            let time = endtime
            let distance = item.createtime.distance(to:time)
            self.focustime.append(timeDate(value: abs(distance), starttime: item.createtime))
            self.alltime.append(abs(distance))
        }
    }
}

struct AnysisData{
    var count : Int
    var AdvanceAllTime : Double
    var ForceStop : Int
    var tag : [String]
}
struct timeDate:Identifiable,Equatable{
    var id = UUID()
    var value : Double
    var starttime : Date
}


struct DistributeData : Identifiable{
    var id = UUID()
    var day : [String]// mounth
    var value : [Double] // alldayvalue
}
