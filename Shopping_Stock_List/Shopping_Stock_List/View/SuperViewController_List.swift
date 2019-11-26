//
//  SuperViewController_List.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/17.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SuperViewController_List: SuperViewController {
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        //tableView設定
        let tabelViewHeight = ViewProperties.mainBoundSize.height - navigationHeight - tabBarHeight
        tableView.frame = CGRect(x: 0, y: navigationHeight, width: ViewProperties.mainBoundSize.width, height: tabelViewHeight)
        tableView.backgroundColor = ViewProperties.tableViewbackgroundColor
        tableView.separatorStyle = .none
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //cellの登録
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell_List")
        
        //ViewにtableViewを追加
        view.addSubview(tableView)
        
        //再描写
        tableView.reloadData()
        
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView()
        bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: mainBoundSize.width, height: 50))
        bannerView.layer.position.x = mainBoundSize.width/2
        bannerView.layer.position.y = mainBoundSize.height - tabBarHeight - 25
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        let gadRequest:GADRequest = GADRequest()
        // テスト用の広告を表示する時のみ使用（申請時に削除）
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "b5c1d38b2d24e4615e2c84cee0b286f8" ];
        bannerView.load(gadRequest)
        self.view.addSubview(bannerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bannerView.adSize = GADAdSizeFromCGSize(CGSize(width: mainBoundSize.width, height: 50))
    }
    
    let tableView = UITableView()
    
    //tableView再描写
    func customReloadData(){
        tableView.reloadData()
    }
    
    //cellの表示設定
    func CellView(indexpath:IndexPath) -> UIView{
        let View = UIView()
        return View
    }
    
    //section内のcell数
    func numberOfRowsInSection(section:Int) -> Int{
        return 0
    }
    
    //データ削除
    func deleteData(indexpath:IndexPath){}
    
    
    ///ShoppingList
    ///Cellの内容表示
    func shoppingCellView(name:String, number:Double?) -> UIView{
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width, height: cellHeight))
        cellView.backgroundColor = UIColor.clear
        ///NameLabe作成
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width*0.5, height: cellHeight))
        nameLabel.text = name
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.5/6)
        nameLabel.textAlignment = NSTextAlignment.center
        cellView.addSubview(nameLabel)
        ///NumberLabe作成
        if let number_ = number{
            if number_ != -9999{
                let numberLabel = UILabel(frame: CGRect(x: mainBoundSize.width*0.5, y: 0, width: mainBoundSize.width*0.5, height: cellHeight))
                numberLabel.text = String(Int(number_))
                numberLabel.textColor = UIColor.black
                numberLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.5/6)
                numberLabel.textAlignment = NSTextAlignment.center
                cellView.addSubview(numberLabel)
            }
        }
        return cellView
    }
    
    ///StockList
    ///Cellの内容表示
    func stockCellView(name:String, date:String?,amount:Double?) -> UIView{
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width, height: cellHeight))
        cellView.backgroundColor = UIColor.clear
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width*0.5, height: cellHeight))
        nameLabel.text = name
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.5/6)
        nameLabel.textAlignment = NSTextAlignment.center
        cellView.addSubview(nameLabel)
        if let date = date {
            let dateLabel = UILabel(frame: CGRect(x: mainBoundSize.width*0.5, y:0 , width: mainBoundSize.width*0.5, height: cellHeight))
            dateLabel.text = date
            dateLabel.textColor = UIColor.black
            dateLabel.textAlignment = NSTextAlignment.center
            dateLabel.font = UIFont.boldSystemFont(ofSize: mainBoundSize.width*0.5/8 )
            dateLabel.textColor = setLabelColor(strDate: date)
            cellView.addSubview(dateLabel)
        }
        
        //残量バーを表示しない
        if amount == nil {
            let layer:CALayer =  CALayer()
            layer.frame = CGRect(x: 0, y: cellHeight*0.93 , width: mainBoundSize.width, height: cellHeight*0.07)
            layer.backgroundColor = UIColor(red: 68/255, green: 157/255, blue: 155/255, alpha: 1).cgColor
            cellView.layer.addSublayer(layer)
            return cellView
        }
        //残量バーを表示する
        let amountBar = CGRect(x: 0, y: 0 , width: mainBoundSize.width, height: cellHeight*0.1)
        let value:CGFloat = CGFloat(amount!)
        let mainWidth = ViewProperties.mainBoundSize.width
        let viewWidth:CGFloat = mainWidth * (value)/100
        let coverView:UIView = UIView(frame: CGRect(x: 0, y: cellHeight*0.9 , width: viewWidth, height: cellHeight*0.1))
        coverView.layer.addSublayer(ViewProperties.gradientLayer(frame: amountBar))
        coverView.clipsToBounds = true
        cellView.addSubview(coverView)
        return cellView
    }
    
    
    ///賞味期限によってラベルの色を変更。
    func setLabelColor(strDate:String) -> UIColor {
        let expDate:Date = self.StringToDate(strDate: strDate)
        if compareDate(date: expDate, afterDay: 0){
            return ViewProperties.Color_red
        }else if compareDate(date: expDate, afterDay: 7){
            return ViewProperties.Color_orange
        }else{
            return UIColor.black
        }
    }
    
    ///文字列をdate型に変換
    func StringToDate(strDate:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.date(from: strDate)!
    }
    
    //入力された日付とセットされた日付の前後を比較する。
    //入力された日付がセットされた日付より前だとtrue。
    func compareDate(date:Date,afterDay:Double) -> Bool{
        let Today = Date()
        let setDate = Today + 60*60*24*afterDay
        let calender = Calendar(identifier: .gregorian)
        let date_omit = roundDate(date: date, cal: calender)
        let setDate_omit = roundDate(date: setDate, cal: calender)
        if date_omit < setDate_omit{
            return true
        }
        return false
    }
    //Date型を年月日までで表す
    func roundDate(date:Date,cal: Calendar) -> Date{
        let _year = cal.component(.year, from: date)
        let _month = cal.component(.month, from: date)
        let _day = cal.component(.day, from: date)
        return cal.date(from: DateComponents(year:_year,month:_month,day:_day))!
    }
    
    
    ///Setting画面
    ///Cellの内容表示
    func settingCellView(indexpath:IndexPath) -> UIView{
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width, height: cellHeight))
        cellView.backgroundColor = UIColor.clear
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width*0.5, height: cellHeight))
        switch indexpath.section {
        case 0:
            switch indexpath.row{
            case 0:
                nameLabel.text = "カテゴリーの編集"
            default:
                nameLabel.text = ""
            }
        default:
            nameLabel.text = ""
        }
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.5/8)
        nameLabel.textAlignment = NSTextAlignment.center
        cellView.addSubview(nameLabel)
        return cellView
    }
    
    
    //リストの順番をカテゴリー毎に分ける。
    func Array_order(ListArray:[DeletedDataClass]) -> [[Any]]{
        var Array = [[]]
        let categoryArray = CategoryClass.CategoryArray
        var count = 0
        for category in categoryArray{
            Array.append([])
            for data in ListArray{
                if data.Category == category{
                    Array[count].append(data)
                }
            }
            count += 1
        }
        return Array
    }
    
    func Array_order_return(Array:[[DeletedDataClass]]) -> [Any]{
        var returnArray:Array<Any> = []
        for datas in Array{
            for data in datas{
                returnArray.append(data)
            }
        }
        return returnArray
    }
    
    ///リスト間のデータやりとり
    //買い物リストからストックリストへ
    func ShoppingToStock(ShoppingData:ShoppingDataClass) -> StockDataClass {
        let returnData = StockDataClass(Name: ShoppingData.Name, Category: ShoppingData.Category, Number: ShoppingData.Number, Image: ShoppingData.Image, Memo: ShoppingData.Memo, ExpDate: nil, Amount: nil)
        return returnData
    }
    //買い物リストから削除リストへ
    func ShoppingToDeleted(ShoppingData:ShoppingDataClass) -> DeletedDataClass {
        let returnData = DeletedDataClass(Name: ShoppingData.Name, Category: ShoppingData.Category, Number: ShoppingData.Number, Image: ShoppingData.Image)
        return returnData
    }
    //ストックリストから削除リストへ
    func StockToDeleted(StockData:StockDataClass) -> DeletedDataClass {
        let returnData = DeletedDataClass(Name: StockData.Name, Category: StockData.Category, Number: StockData.Number, Image: StockData.Image)
        return returnData
    }
    //ストックリストから買い物リストへ
    func StockToShopping(StockData:StockDataClass) -> ShoppingDataClass {
        let returnData = ShoppingDataClass(Name: StockData.Name, Category: StockData.Category, Number: StockData.Number, Image: StockData.Image, Memo: StockData.Memo)
        return returnData
    }
    //削除リストから買い物リストへ
    func DeletedToShopping(DeletedData:DeletedDataClass) -> ShoppingDataClass {
        let returnData = ShoppingDataClass(Name: DeletedData.Name, Category: DeletedData.Category, Number: DeletedData.Number, Image: DeletedData.Image, Memo: nil)
        return returnData
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SuperViewController_List:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell_List", for: indexPath)
        //サブビューを一度全て削除
        let subviews = cell.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        cell.backgroundColor = ViewProperties.CellColor(indexpath: indexPath.row)!
        cell.addSubview(CellView(indexpath: indexPath))
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CategoryClass.CategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    //cellのdelete操作
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        //データ削除
        if editingStyle == .delete{
            deleteData(indexpath: indexPath)
            customReloadData()
        }
    }

    
}

extension SuperViewController_List:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ViewProperties.headerView(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ViewProperties.headerHeight
    }
    
}

