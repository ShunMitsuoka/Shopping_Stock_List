//
//  imageViewForCell.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class imageViewForCell: UIView, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: ViewProperties.mainBoundSize.width*0.6, y: 0, width: ViewProperties.mainBoundSize.width*0.4, height: ViewProperties.imageCellHeight)
//        self.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.red
        imageView.frame = self.frame
        imageView.contentMode = .scaleToFill
        imageView.layer.position = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        self.addSubview(imageView)
    }
    
    var image:UIImage?
    var imageView: UIImageView = UIImageView()
    var imageRect:CGRect?
    var segueDelegate:segueDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    ///Viewがタッチされたら、カメラを起動
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("imageViewがタッチされました")
        if let currentVC = ViewProperties.getTopViewController(){
            switch currentVC{
            case is ShoppingListDetails:
                let ShoppingListDetailsVC = currentVC as! ShoppingListDetails
                self.segueDelegate = ShoppingListDetailsVC
                self.segueDelegate!.segueDelegate()
            case is StockListDetails:
                let StockListDetailsVC = currentVC as! StockListDetails
                self.segueDelegate = StockListDetailsVC
                self.segueDelegate!.segueDelegate()
            case is add_ShoppingListView:
                let add_ShoppingListVC = currentVC as! add_ShoppingListView
                self.segueDelegate = add_ShoppingListVC
                self.segueDelegate!.segueDelegate()
            case is add_StockListView:
                let add_StockListVC = currentVC as! add_StockListView
                self.segueDelegate = add_StockListVC
                self.segueDelegate!.segueDelegate()
            default:
                return
            }
        }
    }
    
    ///画像を表示
    func setImageOnSelf(image:UIImage){
        imageView.image = image
        self.image = image
        print("セットされた画像容量\(image.fileSize())")
    }

}

