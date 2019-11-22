//
//  Post.swift
//  PostOfTheDay
//
//  Created by Aidan Hobler on 11/22/19.
//  Copyright © 2019 Aidan Hobler. All rights reserved.
//

import Foundation

struct Post: Codable {
    var text: String
    var likes: Int
    
}

struct PostResponseData: Codable {
    var posts: [Post]
}

struct PostResponseRaw: Codable {
    var data: PostResponseData
}
