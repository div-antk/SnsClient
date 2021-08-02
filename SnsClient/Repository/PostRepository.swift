//
//  PostRepository.swift
//  SnsClient
//
//  Created by Takuya Ando on 2021/07/20.
//

import Foundation
import Moya
import RxSwift

final class PostRepository {
    private static let apiProvider = MoyaProvider<SnsAPI>()
    private static let disposeBag = DisposeBag()
}

extension PostRepository {
    
    static func getAllPosts() -> Observable<[Post]> {
        return apiProvider.rx.request(.all)
            .map { response in
                let decoder = JSONDecoder()
                return try decoder.decode([Post].self, from: response.data)
            }.asObservable()
    }
    
    
    
    static func postText(text: String) -> () {
        
        apiProvider.rx.request(.postText(text: text))
            .subscribe({ event in
                switch event {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(, from: response.data)
                        
                    }
                
                case .error(let error):
                    <#code#>
                }
            })
    }
//        return apiProvider.rx.request(.postText(text: "text"))
//
//    }
    
    //    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //            if let pickedImage = info[.originalImage] as? UIImage {
    //                ApiManager().request(Api.UploadFiles(caption: "テスト", filepath: pickedImage, fileName: "file")) { (response, error) in
    //                    if let res = response {
    //                        DEBUG.LOG(res)
    //                    }
    //                }
    //            }
    //            imagePicker.dismiss(animated: true, completion: nil)
    //        }
}
