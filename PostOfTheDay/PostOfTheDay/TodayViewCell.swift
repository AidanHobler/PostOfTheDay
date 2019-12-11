//
//  TodayViewCell.swift
//  PostOfTheDay
//
//  Created by Aidan Hobler on 11/22/19.
//  Copyright © 2019 Aidan Hobler. All rights reserved.
//

import UIKit

class TodayViewCell: UITableViewCell {
    var post: Post?
    let postText = UITextView()
    let likes = UILabel()
    var liked = false
    let like = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide
        
        postText.isScrollEnabled = false
        postText.font = UIFont.systemFont(ofSize: 14)
        postText.isEditable = false
        
        likes.textColor = .systemBlue
        

        like.addTarget(self, action: #selector(like_func), for: .touchUpInside)
        like.setTitle("Like", for: .normal)
        like.backgroundColor = .white
        like.setTitleColor(.black, for: .normal)
        like.layer.borderWidth = 1
        like.layer.cornerRadius = 5
        
        contentView.addSubview(postText)
        contentView.addSubview(likes)
        contentView.addSubview(like)
        
        postText.snp.makeConstraints { (make) in
            make.top.equalTo(likes.snp.bottom)
            make.left.equalTo(marginGuide.snp.left)
            make.bottom.equalTo(marginGuide.snp.bottom)
            make.width.equalTo(marginGuide.snp.width)
        }
        
        likes.snp.makeConstraints { (make) in
            make.top.equalTo(marginGuide.snp.top)
            make.left.equalTo(marginGuide.snp.left)
        }
        like.snp.makeConstraints { (make) in
            make.top.equalTo(marginGuide.snp.top)
            make.right.equalTo(marginGuide.snp.right)
            make.width.equalTo(100)
        }
    }
    
    @objc func like_func() {
        NetworkManager.upvote(id: post!.id)
        like.backgroundColor = .systemPink
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
