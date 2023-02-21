//
//  AllData.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/29.
//

import SwiftUI

func initAllData() -> [alldata] {
    var output = [alldata]()
    if let data = UserDefaults.standard.object(forKey: "alldatas") as? Data{
        let datastore = try! JSONDecoder().decode([alldata].self, from: data)
        output = datastore
    }
    return output
}

class AllData : ObservableObject{
    @Published var alldatas : [alldata]
    
    init(_ alldatas : [alldata]){
        self.alldatas = alldatas
    }
    
    func dataStore(){
        let datastore = try! JSONEncoder().encode(self.alldatas)
        UserDefaults.standard.set(datastore, forKey: "alldatas")
    }
}

struct alldata : Identifiable,Codable,Equatable{
    var id = UUID()
    var date : Date
    var datelist : [MyListData]
}
