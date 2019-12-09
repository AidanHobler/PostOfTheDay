//
//  NetworkManager.swift
//  postofthedaybackup
//
//  Created by Ryan Dennis on 12/8/19.
//  Copyright © 2019 Ryan Dennis. All rights reserved.
//

import Foundation
import Alamofire
//
//enum ExampleDataResponse<T: Any> {
//    case success(data: T)
//    case failure(error: Error)
//}

let endpoint = "http://35.229.34.48"

// How do we make network calls?
class NetworkManager {
    static func getPosts(completion: @escaping ([Post]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                print("here")
                
                let jsonDecoder = JSONDecoder()
                
                if let postData = try? jsonDecoder.decode(PostResponseRaw.self, from: data as! Data) {
                    let posts = postData.data.posts
                    completion(posts)
                }
                
//                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
