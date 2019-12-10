//
//  TodayViewCell.swift
//  PostOfTheDay
//
//  Created by Aidan Hobler on 11/22/19.
//  Copyright © 2019 Aidan Hobler. All rights reserved.
//

import UIKit

class TodayViewCell: UITableViewCell {
    let postText = UITextView()
    let likes = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Use marginGuide’s anchor instead of the view’s anchors so the recommended padding is utilized
        let marginGuide = contentView.layoutMarginsGuide
        
        postText.isScrollEnabled = false
        postText.font = UIFont.systemFont(ofSize: 14)
        postText.isEditable = false
        
        contentView.addSubview(postText)
        contentView.addSubview(likes)
        
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
