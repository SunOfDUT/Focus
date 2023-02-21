//
//  URLimage.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/8.
//

import SwiftUI

enum loadstate{
    case loading
    case success
    case failure
}

struct  PublicURLImageView : View {
    var contentmode : Bool
    @ObservedObject var imageLoader: ImageLoaderAndCache

    init(imageurl: String,contentmode:Bool) {
        imageLoader = ImageLoaderAndCache(imageurl:imageurl)
        self.contentmode = contentmode
    }
    
    var body: some View {
        switch imageLoader.state{
        case .loading:
            ProgressView()
        case .failure:
                Text("失败")
         case .success:
            Image(uiImage: UIImage(data: self.imageLoader.imageData) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode:contentmode ? .fill:.fit)
        }
    }
}
class ImageLoaderAndCache: ObservableObject {
    var state = loadstate.loading
    @Published var imageData = Data()

    init(imageurl: String){
        guard let imageURL = URL(string: imageurl) else {return}
        URLCache.shared.diskCapacity = 1024 * 1024 * 800
        URLCache.shared.memoryCapacity = 1024 * 1024 * 950
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30.0)
        if let data = cache.cachedResponse(for: request)?.data {
                DispatchQueue.main.async{
                    print("从缓存中读取")
                    self.imageData = data
                    self.state = .success
                }
        }else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                let cachedData = CachedURLResponse(response: response, data: data)
                    //存储在cathe里面
                    cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            print("从服务端读取")
                            self.imageData = data
                            self.state = .success
                        }
                }else{
                    self.state = .failure
                }
            }).resume()
        }
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
//        print("缓存地址在: \(path)")
    }
}
