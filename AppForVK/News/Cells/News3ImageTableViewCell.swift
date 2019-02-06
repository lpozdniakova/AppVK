//
//  News3ImageTableViewCell.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 28/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit

class News3ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsTopLeftImage: UIImageView!
    @IBOutlet weak var newsTopRightImage: UIImageView!
    @IBOutlet weak var newsBottomImage: UIImageView!
    @IBOutlet weak var tapLike: NewsLikeControl!
    @IBOutlet weak var tapComment: NewsCommentController!
    @IBOutlet weak var tapShare: NewsShareControl!
    @IBOutlet weak var tapCount: NewsCountViewControl!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
