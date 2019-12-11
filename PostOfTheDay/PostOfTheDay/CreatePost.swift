//
//  CreatePost.swift
//  postofthedaybackup
//
//  Created by Ryan Dennis on 12/10/19.
//  Copyright © 2019 MR. All rights reserved.
//

import UIKit

class CreatePost: UIViewController {

    var caption = UILabel()
    var input = UITextView()
    var post = UIButton()
    var user = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.backgroundColor = .white
        
        post.addTarget(self, action: #selector(post_func), for: .touchUpInside)
        post.setTitle("Post", for: .normal)
        post.backgroundColor = .white
        post.setTitleColor(.black, for: .normal)
        post.layer.borderWidth = 1
        post.layer.cornerRadius = 5
        
        caption.text = "Create a Post:"
        
        input.textColor = .black
        input.isEditable = true
        input.layer.borderColor = UIColor.systemGray.cgColor
        input.layer.borderWidth = 1
        input.layer.cornerRadius = 5
        
        user.text = "Username"
        user.textColor = .black
        user.textAlignment = .center
        user.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        user.isEditable = true
        user.isScrollEnabled = false
        user.layer.borderColor = UIColor.systemGray.cgColor
        user.layer.borderWidth = 1
        user.layer.cornerRadius = 5
        
        view.addSubview(caption)
        view.addSubview(input)
        view.addSubview(post)
        view.addSubview(user)
        setupConstraints()
    }
    
    @objc func post_func() {
        // Calls to the post user route work fine in postman, but are having trouble with alamofire
        // For this version, we are simply posting everything to the premade user "Aidan" to at least allow
        // post creation
        NetworkManager.createUser(username: user.text!)
        NetworkManager.createPost(username: "Aidan", body: input.text!)
        input.text = ""
    }
    
    func setupConstraints() {
        caption.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).offset(10)
            make.centerX.equalToSuperview()
//            make.height.equalTo(30)
        }
        user.snp.makeConstraints { (make) in
            make.top.equalTo(caption.snp.bottom).offset(8)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        input.snp.makeConstraints { (make) in
            make.top.equalTo(user.snp.bottom).offset(8)
            make.bottom.equalTo(post.snp.top).offset(-8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
//            make.center.equalToSuperview()
        }
        post.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin).offset(-10)
            make.width.equalTo(50)
        }
    }
}
