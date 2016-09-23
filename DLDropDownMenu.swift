//
//  DLDropDownMenu.swift
//  FileCenter
//
//  Created by 沧海无际 on 15/12/23.
//  Copyright © 2015年 沧海无际. All rights reserved.
//

import UIKit

protocol DLDropDownMenuDelegate: NSObjectProtocol{
    func willShowMenu(_ menu: DLDropDownMenu)
    func didShowMenu(_ menu: DLDropDownMenu)
    func willDismissMenu(_ menu: DLDropDownMenu)
    func didDismissMenu(_ menu: DLDropDownMenu)
    func didSelectedMenu(_ menu: DLDropDownMenu, atIndex: NSInteger)
}

class DLDropDownMenu: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FFTouchableViewDelegate {
    weak var delegate: DLDropDownMenuDelegate?
    var items: [DLDropDownMenuItem] = []
    var menuWidth: CGFloat = UIScreen.main.bounds.width
    var maximumNumberInRow: Int = 4
    var minimumLineSpacing: CGFloat = 0.0
    var minimumInteritemSpacing: CGFloat = 0.0
    
    var rowHeight: CGFloat = 60.0
    var maskBackgroundColor: UIColor?
    var maskBackgroundOpacity: CGFloat = 0.0
    
    var contentView: UICollectionView?
    var containerView: UIView?
    var isOpen: Bool = false
    
    fileprivate var beforeAnimationFrame = CGRect.zero
    fileprivate var afterAnimationFrame = CGRect.zero

    fileprivate var topBackgroundView: FFTouchableView?
    fileprivate var midBackgroundView: FFTouchableView?
    
    fileprivate var numberOfRow: Int = 0
    fileprivate var cellSize = CGSize.zero
    fileprivate var selectedItem: DLDropDownMenuItem?
    
    init(items: [DLDropDownMenuItem], maximumNumberInRow: Int, containerView: UIView) {
        super.init(frame: CGRect.zero)
        
        let layout = UICollectionViewFlowLayout()
        self.contentView = DLDropDownContentView(frame: self.frame, collectionViewLayout:layout)
        self.contentView!.delegate = self
        self.contentView!.dataSource = self
        
        self.items = items
        self.containerView = containerView
        self.selectedItem = self.items[0]
        self.selectedItem!.selected = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func titleAtIndex(_ index: Int) -> String{
        return self.items[index].title
    }
    
    var indexForSelectedItem: Int{
        return self.items.index(of: self.selectedItem!)!
    }
    
    func setSelected(_ index: Int){
        self.selectedItem?.selected = false
        self.selectedItem = self.items[index]
        self.selectedItem?.selected = true
    }
    
    func showInNavigationController(_ nav: UINavigationController, animated: Bool){
        let topHeight = nav.navigationBar.frame.height + UIApplication.shared.statusBarFrame.height
        
        //top mask view
        var topFrame = UIScreen.main.bounds
        topFrame.size.height = topHeight
        self.topBackgroundView = FFTouchableView(frame: topFrame)
        self.topBackgroundView!.delegate = self
        self.topBackgroundView!.fillView.backgroundColor = UIColor.clear
        
        //mid mask view
        var midFrame = UIScreen.main.bounds
        midFrame.origin.y = topHeight
        midFrame.size.height -= (topHeight)
        self.midBackgroundView = FFTouchableView(frame: midFrame)
        self.midBackgroundView!.delegate = self
        self.midBackgroundView!.fillView.backgroundColor = self.maskBackgroundColor
        self.midBackgroundView!.alpha = 0;
        
        //add view
        let keyView = self.keyView(for: self.containerView)
        keyView?.addSubview(self.topBackgroundView!)
        keyView?.addSubview(self.midBackgroundView!)
        keyView?.addSubview(self.contentView!)
        
        //self.containerView!.addSubview(self.midBackgroundView!)
        //self.containerView!.addSubview(self.contentView!)
        
        //menu width
        self.menuWidth = UIScreen.main.bounds.width
        self.numberOfRow = (items.count - 1)/maximumNumberInRow + 1
        
        //content view frame
        let x = (UIScreen.main.bounds.width - self.menuWidth) / 2.0
        let y = UIApplication.shared.statusBarFrame.size.height + nav.navigationBar.dop_height
        let width   = self.menuWidth
        let height  = CGFloat(numberOfRow) * rowHeight
        
        self.beforeAnimationFrame    = CGRect(x: x, y: y, width: width, height: 0)
        self.afterAnimationFrame     = CGRect(x: x, y: y, width: width, height: height)
        
        self.contentView!.frame = self.beforeAnimationFrame
        self.contentView!.alpha = 0.0
        
        self.contentView?.reloadData()
        
        //cell size
        let cellWidth = (self.menuWidth - (CGFloat(maximumNumberInRow)-1) * self.minimumInteritemSpacing)/CGFloat(maximumNumberInRow)
        self.cellSize = CGSize(width: cellWidth, height: rowHeight)
        
        
        self.delegate?.willShowMenu(self)
        
        //start animation
//        UIView.animateWithDuration(0.5,
//            delay: 0.0,
//            usingSpringWithDamping: 0.6,
//            initialSpringVelocity: 1.0,
//            options: [UIViewAnimationOptions.BeginFromCurrentState,UIViewAnimationOptions.CurveEaseInOut],
//            animations: { () -> Void in
//                self.contentView!.frame = self.afterAnimationFrame
//                self.contentView!.alpha = 1.0
//                self.midBackgroundView!.alpha = self.maskBackgroundOpacity
//            },
//            completion:{ (success) -> Void in
//                self.delegate?.didShowMenu(self)
//                self.isOpen = true
//        })
        
        if animated {
            
            UIView.animate(withDuration: 0.2,
                                       animations: { () -> Void in
                                        self.contentView!.frame = self.afterAnimationFrame
                                        self.contentView!.alpha = 1.0
                                        self.midBackgroundView!.alpha = self.maskBackgroundOpacity
                },
                                       completion: { (success) -> Void in
                                        UIView.animate(withDuration: 0.1,
                                            animations: { () -> Void in
                                                self.contentView!.dop_y += 20
                                            },
                                            completion: { (success) -> Void in
                                                UIView.animate(withDuration: 0.1,
                                                    animations: { () -> Void in
                                                        self.contentView!.dop_y -= 20
                                                    },
                                                    completion: { (success) -> Void in
                                                        self.delegate?.didShowMenu(self)
                                                        self.isOpen = true;
                                                })
                                        })
            })
        }else{
            self.contentView!.frame = self.afterAnimationFrame
            self.contentView!.alpha = 1.0
            self.midBackgroundView!.alpha = self.maskBackgroundOpacity
        }
    }
    
    func dismissWithAnimation(_ animated: Bool){
        let completion = { () -> Void in
            self.removeFromSuperview()
            self.topBackgroundView?.removeFromSuperview()
            self.midBackgroundView?.removeFromSuperview()
            self.delegate?.didDismissMenu(self)
            self.isOpen = false
        }
        
        self.delegate?.willDismissMenu(self)
        
        if animated {
            UIView.animate(withDuration: 0.1,
                animations: { () -> Void in
                    self.contentView!.dop_y += 20
                },
                completion: { (success) -> Void in
                    UIView.animate(withDuration: 0.1,
                        animations: { () -> Void in
                            self.contentView!.dop_y -= 20
                        },
                        completion: { (success) -> Void in
                            UIView.animate(withDuration: 0.2,
                                animations: { () -> Void in
                                    self.contentView!.frame = self.beforeAnimationFrame
                                    self.contentView!.alpha = 0.0
                                },
                                completion: { (success) -> Void in
                                    completion()
                            })
                    })
            })
        }else {
            self.contentView!.frame = self.beforeAnimationFrame
            self.contentView!.alpha = 0.0
            completion();
        }
    }
    
    // MARK: - FFTouchableView
    func viewWasTouched(_ view: FFTouchableView!) {
        self.dismissWithAnimation(true)
    }
    
    // MARK: - CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DLDropDownMenuCell", for: indexPath) as! DLDropDownMenuCell
        
        let item = items[(indexPath as NSIndexPath).row]
        cell.setData(item)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.setSelected((indexPath as NSIndexPath).row)
        self.delegate?.didSelectedMenu(self, atIndex: (indexPath as NSIndexPath).row)
        self.dismissWithAnimation(true)
    }

    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return self.minimumLineSpacing
    }
}
