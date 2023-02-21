//
//  ImagePicker.swift
//  Focus
//
//  Created by 孙志雄 on 2022/9/8.
//

import SwiftUI
import Photos

struct myimage : Identifiable,Equatable{
    var id = UUID()
    var image : UIImage?
    var ischeck : Bool
    var assset : PHAsset?
    var imagedata : Data?
}

struct ImageAlbumItem : Identifiable,Equatable{
    var id = UUID()
    var number : Int
    var title : String?
    var fetchResult : PHFetchResult<PHAsset>
}

struct PublicImagePicker: View {
    @State var isshowdetial2 = false
    @State var pickimages : [myimage] = []
    @State var select : Int = 0
    //相簿列表项集合
    @State var items:[ImageAlbumItem] = []
    @State var selectimage = 0
    @State var isshowdetial = false
    @State var selectAlbum : ImageAlbumItem = ImageAlbumItem(number: 0, fetchResult: PHFetchResult<PHAsset>.init())
    var imageManager:PHCachingImageManager = PHCachingImageManager()
    // 调用一个方法 获取到我们手机里面所有的合集 以及合集里面的照片 还有
    @State var isshow = false
    
    var completeHandler:((_ image:[myimage])->())?
    
    var assetGridThumbnailSize = CGSize(width: (UIScreen.main.bounds.width / 4 - 5)*(UIScreen.main.scale) ,
                                        height: (UIScreen.main.bounds.width / 4 - 5)*(UIScreen.main.scale))
    
    @Environment(\.presentationMode) var presentationMode
    @State var ChoiceMode : Bool = true
    
    func GetImage(){
        self.items = []
        PHPhotoLibrary.requestAuthorization{ status in
            // 告诉用户我们需要获取它图库的权限
            guard status == .authorized else {return}
            let smartOptions = PHFetchOptions()
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular,options: smartOptions)
            // 系统默认
            self.convertCollection(collection: smartAlbums)
            // 自己创建的合集
            let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            self.convertCollection(collection: userCollections as! PHFetchResult<PHAssetCollection>)
            self.items.sort{ (item1, item2) -> Bool in
                return item1.fetchResult.count > item2.fetchResult.count
            }
            
            self.selectAlbum = items[0]
        }
    }
    
    func convertCollection(collection: PHFetchResult<PHAssetCollection>){
        for i in 0..<collection.count{
                //获取出但前相簿内的图片
                let resultsOptions = PHFetchOptions()
                resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                                   ascending: false)]
//                resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
//                                                       PHAssetMediaType.image.rawValue)
                let c = collection[i]
                let assetsFetchResult = PHAsset.fetchAssets(in: c , options: resultsOptions)
                //没有图片的空相簿不显示
                if assetsFetchResult.count > 0 {
                    
                    let title = titleOfAlbumForChinse(title: c.localizedTitle)
                    
                    self.items.append(ImageAlbumItem(number: assetsFetchResult.count, title: title, fetchResult: assetsFetchResult))
                }
            }
    }
    
    private func titleOfAlbumForChinse(title:String?) -> String? {
        if title == "Slo-mo" {
            return "慢动作"
        } else if title == "Recently Added" {
            return "最近添加"
        } else if title == "Favorites" {
            return "个人收藏"
        } else if title == "Recently Deleted" {
            return "最近删除"
        } else if title == "Videos" {
            return "视频"
        } else if title == "All Photos" {
            return "所有照片"
        } else if title == "Selfies" {
            return "自拍"
        } else if title == "Screenshots" {
            return "屏幕快照"
        } else if title == "Camera Roll" {
            return "相机胶卷"
        } else if title == "Recents" {
            return "最近项目"
        }
        return title
    }
    
    func GetfristImage(asset:PHAsset) -> UIImage{
          var fistimage = UIImage()
          let options = PHImageRequestOptions()
          options.resizeMode = .exact
          options.deliveryMode = .highQualityFormat
          options.isSynchronous = true
          self.imageManager.requestImage(for:asset, targetSize:self.assetGridThumbnailSize, contentMode: .aspectFit, options: options) { (image, nfo) in
                fistimage = image ?? UIImage()
          }
         return fistimage
    }
    
    func GetPickerData(){
        let options = PHImageRequestOptions()
        options.resizeMode = .exact
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        for (index,i) in self.pickimages.enumerated(){
            self.imageManager.requestImageDataAndOrientation(for: i.assset!, options: options) { data, sc, ascc, asd in
                self.pickimages[index].assset = nil
                self.pickimages[index].imagedata = data
            }
        }
    }
    
    var body: some View {
            VStack{
                HStack(alignment:.top){
                    Button{
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }label: {
                        Image(systemName: "xmark")
                            .frame(width:70)
                    }
                   
                   Spacer()
                
                   Button{
                       withAnimation {
                           isshowdetial2.toggle()
                       }
                   }label: {
                       HStack{
                           if selectAlbum.title != nil{
                               Text(selectAlbum.title!)
                                   .padding(.trailing,2)
                           }
                           
                           Image(systemName: isshowdetial2 ? "chevron.up":"chevron.down")
                               .font(.footnote)
                       }
                   }
                   .padding(.bottom,2)
                    Spacer()
                    
                    Button{
                        self.GetPickerData()
                        self.completeHandler?(self.pickimages)
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Text(ChoiceMode ? "下一步":"完成")
                            .padding(.vertical,5)
                            .frame(width:70)
                    }
                }
                .foregroundColor(.white)
                .padding()
                .padding(.top,40)
                
                
                
                Divider()
                    .foregroundColor(.white)
                
                if !isshowdetial2{
                    if selectAlbum.title != nil{
                        PublicImagePickerDetial(Viewname: selectAlbum.title!, assetsFetchResults:  selectAlbum.fetchResult,number: selectAlbum.number, pickimages: $pickimages, mediaType: .unknown, maxSelected: $select,ChoiceMode:ChoiceMode)
                    }
                }else{
                    ScrollView{
                        
                        VStack{
                            ForEach(Array(items.enumerated()), id:\.offset){ count,index in
                                HStack{
                                    Image(uiImage: GetfristImage(asset: index.fetchResult.firstObject!))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: UIScreen.main.bounds.width / 4 - 5,height: UIScreen.main.bounds.width / 4 - 5)
                                        .clipped()
                                    
                                    Text(index.title!)
                                        .foregroundColor(.white)
                                    Text("(\(index.number))")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                    Spacer()
                                }
                                .onTapGesture {
                                    withAnimation {
                                        self.selectAlbum = index
                                        self.isshowdetial2 = false
                                    }
                                }
                                Divider()
                            }
                        }
                    }
                    .background(Color("black"))
                    .offset(y:isshowdetial2 ? 0:-UIScreen.main.bounds.height)
                }
                Spacer()
            }
            .background(Color("black"))
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.global(qos:.background).async{
                    GetImage()
                }
            }
           
    }

}


struct PublicImagePickerDetial : View{
    var Viewname : String
    var number : Int
    //取得的资源结果，用了存放的PHAsset
    var assetsFetchResults:PHFetchResult<PHAsset>?
     
    //带缓存的图片管理对象
    var imageManager:PHCachingImageManager
     
    //缩略图大小
    var assetGridThumbnailSize:CGSize!
    
    var mediaType : PHAssetMediaType
    
    @State var currentpage = 0
    @State var scrollsize : CGFloat = 0
    @State var ChoiceMode : Bool = true
     
    //每次最多可选择的照片数量
    @Binding var maxSelected:Int
    @State var images : [myimage] = []
    @Binding var pickimages : [myimage]
    @State var hasselect = false
    @State var Columns = Array(repeating:GridItem(.flexible(minimum: 20, maximum: 50), spacing: 55, alignment: .center), count: 4)
    @Environment(\.presentationMode) var presentationMode
    @State var showalert : Bool = false
    @State var showChoice = false
    
    init(Viewname: String, assetsFetchResults: PHFetchResult<PHAsset>?,number:Int,pickimages:Binding<[myimage]>,mediaType:PHAssetMediaType,maxSelected:Binding<Int>,ChoiceMode : Bool){
        let scale = UIScreen.main.scale
        self.assetGridThumbnailSize = CGSize(width: (UIScreen.main.bounds.width / 4 - 5)*scale ,
                                        height: (UIScreen.main.bounds.width / 4 - 5)*scale)
        self.mediaType = mediaType
        self.Viewname = Viewname
        self.assetsFetchResults = assetsFetchResults
        self.number = number
        self._pickimages = pickimages
        self._maxSelected = maxSelected
        self.imageManager = PHCachingImageManager()
        self.imageManager.allowsCachingHighQualityImages = true
        self.stopCaching()
        self.ChoiceMode = ChoiceMode
    }
    
    func stopCaching() {
        imageManager.stopCachingImagesForAllAssets()
    }

    
    func SetImageView(page:Int){
//        var returnimage : UIImage = UIImage()
            if page == 0{
                withAnimation {
                   self.images = []
                }
            }
          let current = page * 28
          let nextcurrent = (page+1) * 28
          let options = PHImageRequestOptions()
          options.resizeMode = .exact
          options.deliveryMode = .highQualityFormat
          options.isSynchronous = true
            for i in current..<nextcurrent{
            guard i < self.assetsFetchResults?.count ?? 0 else {return}
            let asset = self.assetsFetchResults![i]
                if mediaType == .unknown{
                     self.imageManager.requestImage(for:asset,targetSize:self.assetGridThumbnailSize, contentMode: .aspectFill, options: options) { (image, nfo) in
                        withAnimation {
                            self.images.append(myimage(image: image ?? UIImage(), ischeck: false, assset: asset))
                        }
                    }
                }
                else{
                    if asset.mediaType == self.mediaType{
                        self.imageManager.requestImage(for:asset, targetSize:self.assetGridThumbnailSize, contentMode: .aspectFill, options: options) { (image, nfo) in
                            withAnimation {
                                self.images.append(myimage(image: image ?? UIImage(), ischeck: false, assset: asset))
                            }
                        }
                    }
                }
        }
        print(images.count)
    }
    
    var body: some View{
            VStack{
                // 很多图片
                ScrollView{
                    scrollread
                    LazyVGrid(columns:Columns){
                        ForEach(Array(images.enumerated()), id:\.offset){ count,index in
                            Image(uiImage:index.image ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width / 4 - 5,height: UIScreen.main.bounds.width / 4 - 5)
                                .clipped()
                                .onTapGesture {
                                    if maxSelected <= 1{
                                        if images[count].ischeck{
                                            withAnimation {
                                                images[count].ischeck = false
                                                maxSelected -= 1
                                            }
                                        }else{
                                            withAnimation {
                                                images[count].ischeck = true
                                                maxSelected += 1
                                            }
                                        }
                                    }
                                }
                                .overlay(
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Image(index.ischeck ? "CellBlueSelected":"CellGreySelected")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width:30, height:30)
                                                .scaleEffect(index.ischeck ? 1.1:0.8)
                                           
                                        }
                                        Spacer()
                                    }
                                    .padding(5)
                                    .opacity(ChoiceMode ? 1:0)
                                )
                        }
                    }
                  
                }
                .coordinateSpace(name: "scroll")
            }
            .onDisappear(perform: {
                withAnimation {
                    self.maxSelected = 0
                    do{
                        self.images = []
                    }
                    self.currentpage = 0
                }
            })
            .onAppear(perform: {
                DispatchQueue.global().async {
                    self.SetImageView(page:0)
                }
            })
            .onChange(of: self.maxSelected, perform: { newvalue in
                self.pickimages = GetPickeImage(images: self.images)
                if self.maxSelected != 0{
                    withAnimation {
                        showChoice = true
                    }
                }else if self.maxSelected == 0{
                    withAnimation {
                        showChoice = false
                    }
                }
            })
    }
    
    var scrollread : some View{
        GeometryReader{ proxy in
            Color.clear.preference(key: ScrollPreferenceKey.self, value:proxy.frame(in: .named("scroll")).minY)
        }
        .frame(height: 0)
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation {
                
                let rowsize = UIScreen.main.bounds.width / 4
               let currentpageheight = currentpage < 5 ? 0 - currentpage * Int(rowsize * 8 ) : 0 - currentpage * Int(rowsize * 7.5)
               let newsize =  currentpage < 3 ? currentpageheight - Int(rowsize / 2 - CGFloat((20) * currentpage)) : (currentpageheight + (20) * currentpage)
                   if value < CGFloat(newsize){
                       withAnimation {
                           currentpage += 1
                           DispatchQueue.global().async {
                             self.SetImageView(page:currentpage)
                           }
                       }
                   }
//                scrollsize = value
//                       print(currentpage)
//                       print("currentpageheight\(currentpageheight)")
//                       print("newsize\(newsize)")
            }
        }
    }
}

struct ScrollPreferenceKey : PreferenceKey{
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

func GetPickeImage(images:[myimage])->[myimage]{
   var pickimage : [myimage] = []
   for i in images{
       if i.ischeck{
           pickimage.append(i)
       }
   }
   return pickimage
}
