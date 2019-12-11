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

let endpoint_get = "http://35.229.34.38/api/posts/"
let endpoint_user = "http://35.229.34.38/api/users/"
let endpoint_hot = "http://35.229.34.38/api/posts/upvote/"
let endpoint_upvote = "http://35.229.34.38/api/post/"
let endpoint_top = "http://35.229.34.38/api/save/calender/"


// How do we make network calls?
class NetworkManager {
    static func getPostsNew(completion: @escaping ([Post]) -> Void) {
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
    
    static func getPostsHot(completion: @escaping ([Post]) -> Void) {
           Alamofire.request(endpoint_hot, method: .get).validate().responseData{ response in
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
    
    static func createUser(username: String) {
        let parameters: [String: Any] = [
            "username": username
        ]
        Alamofire.request(endpoint_user, method: .post, parameters: parameters, encoding: JSONEncoding.default ).validate().responseData{ response in
            switch response.result {
            case .success(_):
                print("user created")

                
            case .failure(let error):
                print("failed to create user")
                print(error.localizedDescription)
            }
        }
    }
    
    static func upvote(id: Int){
        let url = endpoint_upvote + "\(id)/upvote/"
        Alamofire.request(url, method: .post)
    }
    
    static func getTopPosts(completion: @escaping ([Post]) -> Void) {
        Alamofire.request(endpoint_top, method: .get).validate().responseData{ response in
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
}
