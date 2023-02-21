//
//  ClientData.swift
//  Focus
//
//  Created by 孙志雄 on 2022/8/28.
//

import Foundation

func initSetting()->clientdata{
    var output = clientdata(name: "", image: "",objectid: "", LearningMode: "")
    if let datastore = UserDefaults.standard.object(forKey: "setting") as? Data{
        let data = try! JSONDecoder().decode(clientdata.self, from: datastore)
        output = data
    }
    return output
}

class ClientDatas : ObservableObject{
    @Published var client : clientdata
    
    init(_ client : clientdata){
        self.client = client
    }
    
    func datastore(){
        let datastore = try! JSONEncoder().encode(self.client)
        UserDefaults.standard.set(datastore, forKey: "setting")
    }
}

struct clientdata:Identifiable,Codable{
    var id = UUID()
    var name : String
    var image : String
    var objectid : String
    var LearningMode : String
}
