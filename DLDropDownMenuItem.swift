//
//  DLDropDownMenuItem.swift
//  FileCenter
//
//  Created by 沧海无际 on 15/12/23.
//  Copyright © 2015年 沧海无际. All rights reserved.
//

import UIKit

class DLDropDownMenuItem: NSObject {
    
    var icon: UIImage
    var title: String
    var selected: Bool = false
    
    init(title: String, icon: UIImage) {
        self.title = title
        self.icon = icon
    }

}
