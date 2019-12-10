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
    let reuseID = "PostID"
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Today"
        
//        let testPost = Post(body_post: "This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. This is a test. ", upvotes: 10)
//        let testPost2 = Post(body_post: "This is a shorter test.", upvotes: 130)
        
//        posts.append(testPost)
//        posts.append(testPost2)
        view.addSubview(table)

        table.dataSource = self
        table.register(TodayViewCell.self, forCellReuseIdentifier: reuseID)
        table.estimatedRowHeight = 200
        table.rowHeight = UITableView.automaticDimension
        
        setupConstraints()
        // Do any additional setup after loading the view.
        
        loadPosts()
    }
    
    func loadPosts() {
        NetworkManager.getPosts { (got_posts) in
            self.posts = got_posts
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    
    func setupConstraints() {
        table.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! TodayViewCell
        cell.postText.text = posts[indexPath.row].body_post
        cell.likes.text = String(posts[indexPath.row].upvotes)
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 400
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
