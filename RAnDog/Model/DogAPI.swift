//
//  DogAPI.swift
//  RAnDog
//
//  Created by Abdalah on 10/28/1440 AH.
//  Copyright © 1440 AH Abdalah. All rights reserved.
//

import Foundation
import UIKit
class DOGAPI{
    enum ENDpoint {
        case randomimagefromalldogcollection
        case randomimagefrobreed(String)
        case listbreed
        var url :URL
        {
            return URL(string: self.stringValue)!
        }
        var stringValue:String{
            switch self {
            case .randomimagefromalldogcollection:
                return "https://dog.ceo/api/breeds/image/random"
           
            case .randomimagefrobreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images"
            case .listbreed:
                return "https://dog.ceo/api/breeds/list/all"

    }
        }
    }
    class func requestBreedsList(completionHander: @escaping ([String],Error?) ->Void){
        let listbreed = DOGAPI.ENDpoint.listbreed.url
        let task = URLSession.shared.dataTask(with: listbreed) { (data, response, error) in
            
            guard let data = data else{
                completionHander([],error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})

            completionHander(breeds,error)
            
        }
        task.resume()
    }
    class func requestRandomImage(breed:String ,completionHander: @escaping (DogImage?,Error?) ->Void){
        
        let randomimagedaog = DOGAPI.ENDpoint.randomimagefrobreed(breed).url
        let task = URLSession.shared.dataTask(with: randomimagedaog) { (data, response, error) in
            
            guard let data = data else{
                completionHander(nil,error)
                return
            }
            let decoder = JSONDecoder()
            let imagedata = try! decoder.decode(DogImage.self, from: data)
            completionHander(imagedata,error)

        }
         task.resume()
    }
    class func requestImageFile(url: URL ,completionHander: @escaping (UIImage?,Error?) ->Void) {
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        
        guard let data = data else{
            completionHander(nil,error)
            return
        }
        let downloadimage = UIImage(data:data)
        completionHander(downloadimage,nil)
    })
          task.resume()
    }
  
}
