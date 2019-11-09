//
//  Category_setting.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/11/08.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class Category_setting: SuperViewController_List {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ///tableView設定
        self.tableView.allowsSelection = false
        self.tableView.isScrollEnabled = false
        
        self.CategoryCollectionView.dataSource = self
        self.CategoryCollectionView.delegate = self
        //cellectionView設定
        flowLayout.itemSize = CGSize(width: cellWidth , height: cellWidth)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.CategoryCollectionView.collectionViewLayout = flowLayout
        self.CategoryCollectionView.frame = CGRect(x: 0, y: 0, width: mainBoundSize.width, height: self.tableView.bounds.height - cellHeight)
        self.CategoryCollectionView.backgroundColor = UIColor(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        //cell設定
        self.CategoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        ///LongGesture設定
        let LongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.CellLongPress(recognizer: )))
        LongPressGesture.delegate = self
        CategoryCollectionView.addGestureRecognizer(LongPressGesture)
        ///削除ボタン設定
        setDeleteBtn()
        self.addCellHeight = cellHeight*1.3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryArray = CategoryClass.CategoryArray
    }
    
    
    var textfield:UITextField!
    var CategoryCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    var categoryArray:Array<String>!
    //cellの大きさ
    let cellWidth:CGFloat = (ViewProperties.mainBoundSize.width*0.9 - 40)/3
    //cellの色
    let cellColor:UIColor = UIColor(red: 127/255, green: 175/255, blue: 177/255, alpha: 1)
    let selectedColor:UIColor = UIColor(red: 225/255, green: 178/255, blue: 59/255, alpha: 1)
    let flowLayout = UICollectionViewFlowLayout()
    ///カテゴリー追加cellの高さ
    var addCellHeight:CGFloat!
    ///カテゴリー追加ボタンが押された際のメソッド
    @objc func addButtonEvent(_ sender: UIButton) {
        if let text = self.textfield.text{
            if text != ""{
                if shouldAddCategory(category: text){
                    SaveDataClass.add_Category(category: text)
                    CategoryCollectionViewReload()
                }
            }
            self.textfield.text = nil
        }
    }
    
    //カテゴリー削除ボタンが押された際のメソッド
    @objc func deleteButtonEvent(_ sender: UIButton) {
        if let selectedPath = CategoryCollectionView.indexPathsForSelectedItems{
            for indexpath in selectedPath{
                if shouldDeleteCategory(category: categoryArray[indexpath.row]) {
                    categoryArray.remove(at: indexpath.row)
                }
            }
            SaveDataClass.save_Category_order(categoryArray: categoryArray)
            CategoryCollectionViewReload()
        }
    }
    
    ///カテゴリー追加ボタンの設定メソッド
    func setAddBtn() -> UIButton{
        let addBtn = UIButton(frame: CGRect(x: mainBoundSize.width*0.7, y: 0, width: mainBoundSize.width*0.3, height: addCellHeight))
        addBtn.addTarget(self, action: #selector(addButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        addBtn.setTitle("add".localized, for: .normal )
        addBtn.backgroundColor = UIColor.black
        return addBtn
    }
    
    ///カテゴリー削除ボタンの設定メソッド
    func setDeleteBtn(){
        ///削除ボタンの設定
        let width:CGFloat = mainBoundSize.width*0.2
        let height:CGFloat = cellHeight
        let x:CGFloat = (mainBoundSize.width - width )/2
        let y:CGFloat = self.mainBoundSize.height - tabBarHeight - height*2
        let deleteBtn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        deleteBtn.addTarget(self, action: #selector(deleteButtonEvent(_:)), for: UIControl.Event.touchUpInside)
        deleteBtn.setTitle("delete".localized, for: .normal )
        deleteBtn.backgroundColor = UIColor.red
        ///削除ボタンレイアウト
        self.view.addSubview(deleteBtn)
    }
    
    
    ///CollectionViewをリロードする時のメソッド
    func CategoryCollectionViewReload(){
        categoryArray = CategoryClass.CategoryArray
        CategoryCollectionView.reloadData()
    }
    
    //cellの表示設定
    override func CellView(indexpath:IndexPath) -> UIView {
        var cellView = UIView()
        if indexpath.section == 0{
            cellView = UIView(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width, height: addCellHeight))
            cellView.backgroundColor = UIColor.clear
            textfield = UITextField(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width*0.7, height: addCellHeight))
            textfield.placeholder = "追加カテゴリー"
            textfield.textAlignment = NSTextAlignment.center
            cellView.addSubview(textfield)
            cellView.addSubview(setAddBtn())
        }else if indexpath.section == 1{
            return CategoryCollectionView
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
            return addCellHeight
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
    
    
    ///tableViewのセル、スワイプでの削除不可
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    ///カテゴリーを追加して良いか確認
    func shouldAddCategory(category:String) -> Bool{
        let categoryArray = CategoryClass.CategoryArray
        if categoryArray.contains(category){
            //alert表示
            Error_Alert.ShowAlert(ViewController: self, title: "", message: "category_add_error_001".localized )
            return false
        }
        return true
    }
    
    ///カテゴリーを削除して良いか確認
    func shouldDeleteCategory(category:String) -> Bool{
        //削除して良いか確認
        var Array:[String] = []
        ///ShoppingList確認
        for ShoppingListData in ListArrayClass.ShoppingListArray{
            Array.append(ShoppingListData.Category)
        }
        if Array.contains(category) {
            //alert表示
            Error_Alert.ShowAlert(ViewController: self, title: "", message: "category_delete_error_001".localized )
            return false
        }
        ///StockList確認
        Array = []
        for StockListData in ListArrayClass.StockListArray{
            Array.append(StockListData.Category)
        }
        if Array.contains(category) {
            //alert表示
            Error_Alert.ShowAlert(ViewController: self, title: "", message: "category_delete_error_002".localized )
            return false
        }
        ///DeletedList確認
        Array = []
        for DeletedListData in ListArrayClass.DeletedListArray{
            Array.append(DeletedListData.Category)
        }
        if Array.contains(category) {
            //alert表示
            Error_Alert.ShowAlert(ViewController: self, title: "", message: "category_delete_error_003".localized )
            return false
        }
        
        return true
    }
    
    
    
    
}
//////////
//////////UICollectionViewDataSource////////////
//////////
extension Category_setting:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryClass.CategoryArray.count-1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
        for subview in cell.subviews{
            subview.removeFromSuperview()
        }
        cell.backgroundColor = cellColor
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth))
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = categoryArray[indexPath.row]
        cell.addSubview(label)
        return cell
    }
    
    //Cellの移動を可能に
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movingCell = categoryArray.remove(at: sourceIndexPath.item)
        categoryArray.insert(movingCell, at: destinationIndexPath.item)
    }
    

    
}
//////////
//////////UICollectionViewDelegate////////////
//////////
extension Category_setting:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let all = collectionView.visibleCells
        for cell in all{
            cell.backgroundColor = cellColor
        }
        if let selectedCell = collectionView.cellForItem(at: indexPath){
            selectedCell.backgroundColor = selectedColor
        }
    }
}
//////////
//////////UIGestureRecognizerDelegate////////////
//////////
extension Category_setting:UIGestureRecognizerDelegate{

    @objc func CellLongPress(recognizer:UILongPressGestureRecognizer){
        print("Cellが長押しされました。")
        switch recognizer.state {

        case .began:
            guard let selectedIndexPath = CategoryCollectionView.indexPathForItem(at: recognizer.location(in: CategoryCollectionView)) else {
                break
            }
            CategoryCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)

        case .changed:
            CategoryCollectionView.updateInteractiveMovementTargetPosition(recognizer.location(in: CategoryCollectionView))
            print(recognizer.location(in: CategoryCollectionView))

        case .ended:
            CategoryCollectionView.endInteractiveMovement()
            SaveCategoryOrder()

        default:
            CategoryCollectionView.cancelInteractiveMovement()
        }

    }
    
    ///移動が終わり次第カテゴリーを保存
    func SaveCategoryOrder(){
        SaveDataClass.save_Category_order(categoryArray: self.categoryArray)
    }

}

