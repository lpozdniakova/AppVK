//
//  NewsPostTableViewCell.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 16/03/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit
import Kingfisher

class NewsPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconComment: UIImageView!
    @IBOutlet weak var iconCommentWidth: NSLayoutConstraint!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var iconShare: UIImageView!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var iconViews: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with news: News) {
        let urlUserImage = news.titlePostPhoto
        userImage.kf.setImage(with: URL(string: urlUserImage))
        userName.text = news.titlePostLabel
        newsDate.text = String(news.titlePostTime)
        newsText.text = news.postText
        
        if news.userLikes == 1 {
            likeButton.setImage(UIImage(named: "Heart"), for: .normal)
            likeLabel.textColor = UIColor(red: 254/255, green: 0/255, blue: 41/255, alpha: 1)
        } else {
            likeButton.setImage(UIImage(named: "HeartWhite"), for: .normal)
            likeLabel.textColor = UIColor.vk_color
        }
        
        likeLabel.text = String(news.likesCount)
        
        if news.commentCanPost == 1 {
            commentLabel.text = String(news.commentsCount)
            iconCommentWidth.constant = 20
            commentLabelWidth.constant = 40
            commentLeadingConstraint.constant = 8
        } else {
            iconCommentWidth.constant = 0
            commentLabelWidth.constant = 0
            commentLeadingConstraint.constant = 0
        }
        
        shareLabel.text = String(news.repostsCount)
        viewsLabel.text = String(news.viewsCount)
        
    }

    @IBAction func tapLikeButton(_ sender: UIButton) {
        if likeButton.currentImage == UIImage(named: "HeartWhite") {
            likeButton.setImage(UIImage(named: "Heart"), for: .normal)
            likeLabel.textColor = UIColor(red: 254/255, green: 0/255, blue: 41/255, alpha: 1)
            
            if let likesTest = Int(likeLabel.text!) {
                if likesTest < 1000 {
                    likeLabel.text = String(Int(likeLabel.text!)! + 1)
                }
            }
        } else {
            likeButton.setImage(UIImage(named: "HeartWhite"), for: .normal)
            likeLabel.textColor = UIColor.vk_color
            if let likesTest = Int(likeLabel.text!) {
                if likesTest < 1000 {
                    likeLabel.text = String(Int(likeLabel.text!)! - 1)
                }
            }
        }
    }
}
