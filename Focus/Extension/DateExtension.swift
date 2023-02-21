//
//  DateExtension.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/28.
//

import Foundation
import SwiftUI

func GetTime(createtime:Date,EndTime:Date)->String{
    let time = (createtime.distance(to: EndTime))
    var output : String = ""
    let hour = Int(time) / 3600
    let min = Int(time) / 60 - hour * 60
    if min != 0 && hour == 0{
        output = "\(min)分钟"
    }else if  min == 0 && hour != 0{
        output = "\(hour)小时"
    }else if min != 0 && hour != 0{
        output = "\(hour)小时 \(min)分钟"
    }else if min == 0 &&  hour == 0{
        output = "\(Int(time))秒"
    }
    return output
}

func GetTime2(time:TimeInterval)->String{
    var output : String = ""
    let hour = Int(time) / 3600
    let min = Int(time) / 60 - hour * 60
    if min != 0 && hour == 0{
        output = "\(min)分钟"
    }else if  min == 0 && hour != 0{
        output = "\(hour)小时"
    }else if min != 0 && hour != 0{
        output = "\(hour)小时\(min)分钟"
    }else if min == 0 &&  hour == 0{
        output = "\(Int(time))秒"
    }
    return output
}

func GetTime3(createtime:Date,EndTime:Date)->String{
    let time = (createtime.distance(to: EndTime))
    var output : String = ""
    let date = time / 86400
    if date == 0{
        output = "今天"
    }else{
        output = "\(Int(date))天"
    }
    return output
}

func GetTime4(time:TimeInterval)->String{
    var output : String = ""
    let hour = Int(time) / 3600
    let min = Int(time) / 60 - hour * 60
    let sec = Int(time) - hour * 3600 - min * 60
    output = "\(hour)小时\(min)分钟\(sec)秒"
    return output
}
func formatted(time:Date)->String{
    let formmat = DateFormatter()
    formmat.dateFormat = "HH:mm"
    return formmat.string(from: time)
}

func formatted3(time:Date)->String{
    let formmat = DateFormatter()
    formmat.dateFormat = "yy-MM-dd HH:mm"
    return formmat.string(from: time)
}

func formatted2(time:Date)->String{
    let formmat = DateFormatter()
    formmat.dateFormat = "HH:mm:ss"
    return formmat.string(from: time)
}

func formatted1(time:Date)->String{
    let formmat = DateFormatter()
    formmat.dateFormat = "yyyy-MM-dd"
    return formmat.string(from: time)
}

func SumTime(time:[Double])->Double{
    var item  = 0.0
    for i in time{
        item += i
    }
    return item
}


extension Date{
    public var CollageExam : Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentyear = dateFormatter.string(from: Date())
        let stirng = String(Int(currentyear)! + 1) + "-06-07"
        let currentstirng =  String(Int(currentyear)!) + "-06-07"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter2.date(from: stirng)
        let currentdate =  dateFormatter2.date(from: currentstirng)
        let distance = Date().distance(to: currentdate!)
        if distance < 0{
            return date!
        }else{
            return currentdate!
        }
    }
    
    public var graduateExam : Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentyear = dateFormatter.string(from: Date())
        let stirng = String(Int(currentyear)! + 1) + "-12-25"
        let currentstirng =  String(Int(currentyear)!) + "-12-25"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter2.date(from: stirng)
        let currentdate =  dateFormatter2.date(from: currentstirng)
        let distance = Date().distance(to: currentdate!)
        if distance < 0{
            return date!
        }else{
            return currentdate!
        }
    }
}
func GetMyMaxTime(time:[timeDate])->(Date,Date){
    guard time != [] else {return(Date(),Date())}
    let maxdate = time.max { timeDate1, timeDate2 in
        timeDate1.value < timeDate2.value
    }!
    return (maxdate.starttime,maxdate.starttime.advanced(by: maxdate.value))
}
func GetValue(time:[timeDate])->[Double]{
    var data : [Double] = []
    for i in time{
        data.append(i.value)
    }
    return data
}


