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
        self.frame = CGRect(x: 0, y: 0, width: ViewProperties.mainBoundSize.width*0.6, height: ViewProperties.cellHeight*3)
        self.backgroundColor = UIColor.white
        collectionView.backgroundColor = UIColor.gray
        
        //delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        //cellectionView設定
        let cellWidth:CGFloat = (ViewProperties.mainBoundSize.width*0.6 - 40)/3
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
    
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    let flowLayout = UICollectionViewFlowLayout()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CategoryView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
}

extension CategoryView: UICollectionViewDelegate{
    
}
