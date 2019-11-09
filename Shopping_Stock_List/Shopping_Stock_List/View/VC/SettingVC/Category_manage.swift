//
//  Category_manage.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/11/09.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class Category_manage: SuperViewController_List {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.CategoryCollectionView.delegate = self
        self.CategoryCollectionView.dataSource = self
        
        ///collectionView設定
        let collectionViewFrame:CGRect = CGRect(x: 0, y: 0, width: mainBoundSize.width, height: self.tableView.bounds.height - cellHeight)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellWidth , height: cellWidth)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.CategoryCollectionView.frame = collectionViewFrame
        self.CategoryCollectionView.collectionViewLayout = flowLayout
        self.CategoryCollectionView.backgroundColor = UIColor.red
        self.CategoryCollectionView.isScrollEnabled = true
        self.CategoryCollectionView.allowsSelection = true
        //cell設定
        self.CategoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        print("viewDidLoad終了")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryArray = CategoryClass.CategoryArray
    }
    
    var categoryArray:Array<String>!
    var textfield:UITextField!
    var CategoryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    //cellの大きさ
    let cellWidth:CGFloat = (ViewProperties.mainBoundSize.width*0.9 - 40)/3
    //cellの色
    let cellColor:UIColor = UIColor(red: 127/255, green: 175/255, blue: 177/255, alpha: 1)
    let selectedColor:UIColor = UIColor(red: 225/255, green: 178/255, blue: 59/255, alpha: 1)
    
    ///カテゴリー追加ボタンが押された際のメソッド
    @objc func addButtonEvent(_ sender: UIButton) {
        if let text = self.textfield.text{
            if text != ""{
                SaveDataClass.add_Category(category: text)
            }
        }
    }

    //cellの表示設定
    override func CellView(indexpath:IndexPath) -> UIView {
        var cellView = UIView()
        if indexpath.section == 0{
            cellView = UIView(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width, height: cellHeight))
            cellView.backgroundColor = UIColor.clear
            textfield = UITextField(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width*0.7, height: cellHeight))
            textfield.placeholder = "追加カテゴリー"
            textfield.textAlignment = NSTextAlignment.center
            cellView.addSubview(textfield)
            let addBtn = UIButton(frame: CGRect(x: mainBoundSize.width*0.7, y: 0, width: mainBoundSize.width*0.3, height: cellHeight))
            addBtn.addTarget(self, action: #selector(addButtonEvent(_:)), for: UIControl.Event.touchUpInside)
            addBtn.setTitle("追加", for: .normal )
            cellView.addSubview(addBtn)
        }else if indexpath.section == 1{
            print("コレクションViewをCellとして返します。")
            cellView.addSubview(CategoryCollectionView)
            return cellView
        }
        return cellView
    }
    
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return cellHeight*1.3
        }else if indexPath.section == 1{
            return self.tableView.bounds.height - cellHeight
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = UIView()
        headerview.frame.size = CGSize(width: ViewProperties.mainBoundSize.width, height: 40 )
        headerview.backgroundColor = UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
        let BottomLine = CALayer()
        BottomLine.frame = CGRect(x: 0, y: 28, width: ViewProperties.mainBoundSize.width,height: 2)
        BottomLine.backgroundColor = UIColor(red: 120/255, green: 91/255, blue: 84/255, alpha: 1).cgColor
        headerview.layer.addSublayer(BottomLine)
        let headerLabel = UILabel(frame: CGRect(x:10, y: -3, width: mainBoundSize.width, height: 40))
        switch section {
        case 0:
            headerLabel.text = "カテゴリー追加"
        case 1:
            headerLabel.text = "カテゴリー削除、順序編集"
        default:
            headerLabel.text = ""
        }
        headerLabel.font = UIFont.systemFont(ofSize: 25)
        headerview.addSubview(headerLabel)
        return headerview
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

}

extension Category_manage:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("numberOfItemsInSection")
        return CategoryClass.CategoryArray.count-1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        cell.backgroundColor = cellColor
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth))
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = categoryArray[indexPath.row]
        cell.addSubview(label)
        cell.isSelected = false
        collectionView.deselectItem(at: indexPath, animated: true)
        return cell
    }
    
    
}

extension Category_manage: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("delegateはされてる")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell選ばれた")
    }
}
