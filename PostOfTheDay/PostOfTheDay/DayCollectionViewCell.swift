//
//  DayCollectionViewCell.swift
//  PostOfTheDay
//
//  Created by Ryan Dennis on 12/6/19.
//  Copyright © 2019 Ryan Dennis. All rights reserved.
//

import UIKit
import SnapKit

class DayCollectionViewCell: UICollectionViewCell {
    var dayLabel: UILabel!
    var detailLabel: UILabel!
    var likes: UILabel!
    
    let padding: CGFloat = 8
    let labelHeight: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemTeal
        self.contentView.layer.cornerRadius = 20.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = .init(srgbRed: 205/255, green: 200/255, blue: 190/255, alpha: 1.0)
        self.contentView.layer.masksToBounds = true
        
        dayLabel = UILabel()
        dayLabel.textColor = .black
        dayLabel.textAlignment = .left
        dayLabel.font = UIFont.systemFont(ofSize: 26)
        contentView.addSubview(dayLabel)
        
        detailLabel = UILabel()
        detailLabel.textColor = .black
        detailLabel.textAlignment = .left
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.numberOfLines = 0
        contentView.addSubview(detailLabel)
        
        likes = UILabel()
        likes.textColor = .black
        likes.textAlignment = .right
        likes.font = UIFont.systemFont(ofSize: 26)
        contentView.addSubview(likes)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        dayLabel.snp.makeConstraints { make in
            make.top.left.equalTo(marginGuide).offset(padding*2)
//            make.width.height.equalTo(labelHeight)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(padding)
            make.left.equalTo(dayLabel)
            make.right.equalToSuperview()
        }
        
        likes.snp.makeConstraints { (make) in
            make.top.right.equalTo(marginGuide).offset(padding*2)
            make.right.equalTo(marginGuide).offset(-padding*2)
        }
    }
    
    func configure(for post: Post) {
        let postText = post.body_post
        let postDate = post.time_stamp
        let arr = postDate.split(separator: " ")
        dayLabel.text = String(arr[0])
        detailLabel.text = postText
        likes.text = "\(post.upvotes) likes"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
