//
//  DLDropDownMenuCell.swift
//  FileCenter
//
//  Created by 沧海无际 on 15/12/23.
//  Copyright © 2015年 沧海无际. All rights reserved.
//

import UIKit

class DLDropDownMenuCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ item: DLDropDownMenuItem){
        self.iconView.image = item.icon
        self.titleLabel.text = item.title
        if item.selected {
            self.titleLabel.textColor = UIColor.systemBlueColor()
        }else{
            self.titleLabel.textColor = UIColor.black
        }
    }
}
