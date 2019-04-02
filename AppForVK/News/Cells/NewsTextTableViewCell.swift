//
//  NewsTextTableViewCell.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 31/03/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsTextCell"

    @IBOutlet weak var newsText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
