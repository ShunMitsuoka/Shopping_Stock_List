//
//  CategoryView.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/18.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "collectionCell"

class CategoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: ViewProperties.mainBoundSize.width*0.6, height: ViewProperties.imageCellHeight)
        self.backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        
        //delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        //cellectionView設定
        flowLayout.itemSize = CGSize(width: cellWidth , height: cellWidth)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.frame = self.bounds
        //cell設定
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        
        self.addSubview(collectionView)
    }
    
    //cellの大きさ
    let cellWidth:CGFloat = (ViewProperties.mainBoundSize.width*0.6 - 40)/3
    //cellの色
    let cellColor:UIColor = UIColor(red: 127/255, green: 175/255, blue: 177/255, alpha: 1)
    let selectedColor:UIColor = UIColor(red: 225/255, green: 178/255, blue: 59/255, alpha: 1)
    
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    let flowLayout = UICollectionViewFlowLayout()
    var category:String = CategoryClass.CategoryArray.last!
    // new = 0
    // detail = 1
    var identfierID:Int = 0
    var setCategoryName:String!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CategoryView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryClass.CategoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        
        cell.backgroundColor = cellColor
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth))
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = CategoryClass.CategoryArray[indexPath.row]
        
        cell.addSubview(label)
        
        
        if identfierID == 0{
            if indexPath.row == CategoryClass.CategoryArray.count - 1 {
                cell.backgroundColor = selectedColor
            }
            return cell
        } else if identfierID == 1{
            //Details画面での設定用
            if indexPath.row == CategoryClass.CategoryIndex(categoryName: self.setCategoryName){
                cell.backgroundColor = selectedColor
            }
            return cell
        }
        fatalError()
        
    }
    
    
}

extension CategoryView: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let all = collectionView.visibleCells
        for cell in all{
            cell.backgroundColor = cellColor
        }
        if let selectedCell = collectionView.cellForItem(at: indexPath){
            selectedCell.backgroundColor = selectedColor
            category = CategoryClass.CategoryArray[indexPath.row]
        }
    }
    
}
