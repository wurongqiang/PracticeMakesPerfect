//
//  PostListTableView.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func set(postViewParam: PostViewParam) {
        titleLabel.text = postViewParam.title
        bodyLabel.text = postViewParam.body
        
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf.setImage(
            with: postViewParam.image,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        pictureImageView.layer.cornerRadius = 10
    }
    
    
}
