//
//  Post.swift
//  PostOfTheDay
//
//  Created by Aidan Hobler on 11/22/19.
//  Copyright © 2019 Aidan Hobler. All rights reserved.
//

import Foundation

struct Comment: Codable {
    var body_comment: String
    var id: Int
    var post_id: Int
    var time_stamp: String
    var user_id: Int
}

struct Post: Codable {
    var body_post: String
    var comments: [Comment]
    var id: Int
    var time_stamp: String
    var upvotes: Int
    var user_id: Int
    
}

struct PostResponseData: Codable {
    var data: [Post]
//    var success: Bool
}

//struct PostResponseRaw: Codable {
//    var data: PostResponseData
//}
