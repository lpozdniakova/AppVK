//
//  NewsTableViewCell.swift
//  AppForVK
//
//  Created by Mikhail Semerikov on 24/01/2019.
//  Copyright © 2019 Семериков Михаил. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let numberOfImage = 7
    
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UICollectionView!
    @IBOutlet weak var tapLike: NewsLikeControl!
    @IBOutlet weak var tapComment: NewsCommentController!
    @IBOutlet weak var tapShare: NewsShareControl!
    @IBOutlet weak var tapCount: NewsCountViewControl!
    
    var arrayNewsImage: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.dataSource = self
        newsImage.delegate = self
        newsImage.register(UINib.init(nibName: "NewsImageCell", bundle: nil), forCellWithReuseIdentifier: "NewsImageCell")
        setCustomFlowLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfImage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newsImage.dequeueReusableCell(withReuseIdentifier: "NewsImageCell", for: indexPath) as! NewsImageCell
        if (indexPath.row < numberOfImage) {
            cell.newsImage.image = UIImage(named: arrayNewsImage[indexPath.row])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let reverseAspectRatio = 0.5625
        let reverseAspectRatioForTopRow = 0.667
        let margins: CGFloat = 10
        let effectiveHeight = newsImage.visibleSize.height - margins
        let cellCount = indexPath.row + 1
        var picHeight = CGFloat()
        var picWidth: CGFloat { return picHeight/CGFloat(reverseAspectRatio) }
        var cellSize = CGSize(width: 44, height: 44)
        
        if (cellCount < 5) {
            picHeight = effectiveHeight * 0.15625
            let picWidthForTopRow = picHeight/CGFloat(reverseAspectRatioForTopRow)
            cellSize = CGSize(width: picWidthForTopRow, height: picHeight)
        } else if (cellCount > 4 && cellCount < 7) {
            picHeight = effectiveHeight * 0.28125
            cellSize = CGSize(width: picWidth, height: picHeight    )
        } else {
            picHeight = effectiveHeight * 0.5625
            cellSize = CGSize(width: picWidth, height: picHeight)
        }
        return cellSize
    }
    
    func setCustomFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 4
        newsImage.collectionViewLayout = flowLayout
    }
    
}
