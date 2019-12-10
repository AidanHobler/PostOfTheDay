//
//  ViewController.swift
//  PostOfTheDay
//
//  Created by Aidan Hobler on 11/18/19.
//  Copyright © 2019 Aidan Hobler. All rights reserved.
//

import UIKit

class CreatePost: UIViewController {

    var caption = UILabel()
    var input = UITextField()
    var post = UIButton()
    var user = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post"
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        post.addTarget(self, action: #selector(post_func), for: .touchUpInside)
        caption.text = "Create a Post:"
        view.addSubview(caption)
        view.addSubview(input)
        view.addSubview(post)
        setupConstraints()
    }
    
    @objc func post_func() {
        NetworkManager.createUser(username: user.text!, body: input.text!)
        input.text = ""
    }
    
    func setupConstraints() {
        caption.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.center.equalToSuperview()
            make.height.equalTo(30)
        }
    }


}

