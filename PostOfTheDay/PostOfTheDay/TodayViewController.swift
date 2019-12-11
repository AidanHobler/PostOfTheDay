//
//  TodayViewController.swift
//  PostOfTheDay
//
//  Created by Aidan Hobler on 11/22/19.
//  Copyright © 2019 Aidan Hobler. All rights reserved.
//

import UIKit
import SnapKit

class TodayViewController: UIViewController, UITableViewDataSource {
    
    var table = UITableView()
    var toggle = UIButton()
    let reuseID = "PostID"
    var posts: [Post] = []
    // Map of post ids to whether or not they've been upvoted
    var upvoted: [Int: Bool] = [:]
    // Whether or not currently sorted by hot
    var hot: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Today"
        
//        let testPost = Post(body_post: "This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. ", upvotes: 10)
//        let testPost2 = Post(body_post: "This is a shorter test.", upvotes: 130)
        
//        posts.append(testPost)
//        posts.append(testPost2)
        view.addSubview(table)

        toggle.setTitle("Newest Posts", for: .normal)
        toggle.addTarget(self, action: #selector(toggleFunc), for: .touchUpInside)
        toggle.backgroundColor = .systemBlue
        toggle.setTitleColor(.black, for: .normal)
        toggle.layer.borderWidth = 1
        toggle.layer.cornerRadius = 5
        view.addSubview(toggle)
        
        table.delegate = self
        table.dataSource = self
        table.register(TodayViewCell.self, forCellReuseIdentifier: reuseID)
        table.rowHeight = UITableView.automaticDimension
        
        setupConstraints()
        // Do any additional setup after loading the view.
        
        loadPostsNew()
    }
    
    @objc func toggleFunc() {
        if(hot) {
            loadPostsNew()
            hot = false
            toggle.setTitle("Newest Posts", for: .normal)
            toggle.backgroundColor = .systemBlue
        }
        else {
            loadPostsHot()
            hot = true
            toggle.setTitle("Hottest Posts", for: .normal)
            toggle.backgroundColor = .systemRed
            
        }
    }
    
    func loadPostsHot() {
        NetworkManager.getPostsHot { (got_posts) in
            self.posts = got_posts
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
        
    }

    func loadPostsNew() {
        NetworkManager.getPostsNew { (got_posts) in
            
            self.posts = got_posts
            self.posts.reverse()
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    func setupConstraints() {
        toggle.snp.makeConstraints { (make) in
            make.top.equalTo(table.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(160)
        }
        table.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(toggle.snp.top)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! TodayViewCell
        cell.postText.text = posts[indexPath.row].body_post
        cell.likes.text = String(posts[indexPath.row].upvotes)
        let post = posts[indexPath.row]
        cell.post = post
        cell.like.backgroundColor = .systemBlue
//        if let has_been_clicked = upvoted[post.id] {
//            if (has_been_clicked) {
//                cell.likes.textColor = .systemPink
//            }
//        }
        // Only have access to user id number, so posts are anonymous for now
        //cell.user.text = posts[indexPath.row].username
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! TodayViewCell
//
//        cell.textLabel.text =
//
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        print("Selected")
        if let has_been_clicked = upvoted[post.id] {
            if(!has_been_clicked) {
                NetworkManager.upvote(id: post.id)
                upvoted[post.id] = true
                let cell = tableView.cellForRow(at: indexPath) as! TodayViewCell
            }
        }
        else {
            NetworkManager.upvote(id: post.id)
            upvoted[post.id] = true
            let cell = tableView.cellForRow(at: indexPath) as! TodayViewCell
        }
    }
}
