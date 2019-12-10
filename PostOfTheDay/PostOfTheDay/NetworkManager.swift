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

let endpoint_get = "http://35.229.34.38/api/posts"
let endpoint_user = "http://35.229.34.38/api/users"


// How do we make network calls?
class NetworkManager {
    static func getPosts(completion: @escaping ([Post]) -> Void) {
        Alamofire.request(endpoint_get, method: .get).validate().responseData{ response in
            switch response.result {
            case .success(let data):

                let jsonDecoder = JSONDecoder()
                
                if let postData = try? jsonDecoder.decode(PostResponseData.self, from: data) {
                    let posts = postData.data
                    completion(posts)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func createPost(username: String, body: String) {
        let parameters: [String: Any] = [
            "username": username,
            "body": body
        ]
        Alamofire.request(endpoint_get, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData{ response in
            switch response.result {
            case .success(let data):
                print("success")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func createUser(username: String, body: String) {
        let parameters: [String: Any] = [
            "username": username
        ]
        Alamofire.request(endpoint_user, method: .post, parameters: parameters, encoding: URLEncoding(destination: .queryString)).validate().responseData{ response in
            switch response.result {
            case .success(_):
                print("user created")
                createPost(username: username, body: body)
                
                
            case .failure(let error):
                print(error.localizedDescription)
                createPost(username: username, body: body)
            }
        }
        
    }
}
