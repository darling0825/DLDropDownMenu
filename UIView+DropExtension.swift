//
//  UIView+DropExtension.swift
//  FileCenter
//
//  Created by 沧海无际 on 15/12/23.
//  Copyright © 2015年 沧海无际. All rights reserved.
//

import UIKit

extension UIView {

    var dop_x: CGFloat {
        get{
            return self.frame.origin.x;
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var dop_y: CGFloat {
        get{
            return self.frame.origin.y;
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var dop_width: CGFloat {
        get{
            return self.frame.size.width;
        }
        set{
            var frame = self.frame;
            frame.size.width = newValue;
            self.frame = frame;
        }
    }
    
    
    var dop_height: CGFloat {
        get{
            return self.frame.size.height;
        }
        set{
            var frame = self.frame;
            frame.size.height = newValue;
            self.frame = frame;
        }
    }
    
    var dop_size: CGSize {
        get{
            return self.frame.size;
        }
        set{
            var frame = self.frame;
            frame.size = newValue;
            self.frame = frame;
        }
    }

    var dop_origin: CGPoint {
        get{
            
            return self.frame.origin;
        }
        set{
            var frame = self.frame;
            frame.origin = newValue;
            self.frame = frame;
        }
    }
}
