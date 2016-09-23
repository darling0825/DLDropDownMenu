//
//  DLDropDownContentView.swift
//  FileCenter
//
//  Created by 沧海无际 on 15/12/23.
//  Copyright © 2015年 沧海无际. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "DLDropDownMenuCell"

class DLDropDownContentView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        config()
    }
    
    
    func config(){
        let cellNib = UINib(nibName: "DLDropDownMenuCell", bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: "DLDropDownMenuCell")
        
        self.backgroundColor = UIColor.white
        
        self.isScrollEnabled = false
    }

}
