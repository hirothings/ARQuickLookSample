//
//  ItemCollectionViewCell.swift
//  ARQuickLookSample
//
//  Created by hirothings on 2018/06/12.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: Item) {
        imageView.image = UIImage(named: item.name)
        label.text = item.name
    }
}
