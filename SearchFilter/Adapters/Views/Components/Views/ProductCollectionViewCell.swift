//
//  ProductListTableView.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func set(productViewParam: ProductViewParam) {
        nameLabel.text = productViewParam.name
        priceLabel.text = productViewParam.price
        
        pictureImageView.kf.indicatorType = .activity
        pictureImageView.kf.setImage(
            with: productViewParam.imageURL,
            placeholder: UIImage(named: "placeholder"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
    
}
