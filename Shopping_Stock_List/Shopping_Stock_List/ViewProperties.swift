//
//  ViewProperties.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation
import UIKit

class ViewProperties {
    
    
    //screenSize
    static let mainBoundSize:CGSize = UIScreen.main.bounds.size
    
    
    //背景色
    static let backgroundColor:UIColor = UIColor.init(red: 127/255, green: 175/255, blue: 177/255, alpha: 1)
    static let tableViewbackgroundColor = UIColor(red: 230/255, green: 217/255, blue: 205/255, alpha: 1)
//        UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
    static let Color_red = UIColor(red: 215/255, green: 66/255, blue: 96/255, alpha: 1)
    static let Color_yellow = UIColor(red: 225/255, green: 178/255, blue: 59/255, alpha: 1)
    static let Color_orange = UIColor(red: 245/255, green: 162/255, blue: 0/255, alpha: 1)
    
    //Cellの色
    static func CellColor(indexpath:Int) -> UIColor?{
        switch indexpath % 2{
        case 0:
            return UIColor.init(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        case 1:
            return UIColor.init(red: 236/255, green: 230/255, blue: 229/255, alpha: 1)
        default:
            return nil
        }
    }
    
    
    //tableview
    
    //cell size
    static var cellHeight:CGFloat {
        get{
            let cellheight = mainBoundSize.height/14
            return cellheight
        }
    }
    static var imageCellHeight:CGFloat = ViewProperties.cellHeight*3
    
    //内容表示
    
    //header情報
    static func headerView(section:Int) -> UIView{
        let headerview = UIView()
        headerview.frame.size = CGSize(width: ViewProperties.mainBoundSize.width, height: 30 )
        headerview.backgroundColor = UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
        let BottomLine = CALayer()
        BottomLine.frame = CGRect(x: 0, y: 26, width: ViewProperties.mainBoundSize.width,height: 2)
        BottomLine.backgroundColor = UIColor(red: 120/255, green: 91/255, blue: 84/255, alpha: 1).cgColor
        headerview.layer.addSublayer(BottomLine)
        let headerLabel = UILabel(frame: CGRect(x:10, y: -2, width: mainBoundSize.width, height: 30))
        headerLabel.text = CategoryClass.CategoryArray[section]
        headerLabel.font = UIFont.systemFont(ofSize: 25)
        headerview.addSubview(headerLabel)
        return headerview
    }
    
    ///setting画面のheader
    static func SettingheaderView(section:Int) -> UIView{
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
            headerLabel.text = "カテゴリー"
        default:
            headerLabel.text = ""
        }
        headerLabel.font = UIFont.systemFont(ofSize: 25)
        headerview.addSubview(headerLabel)
        return headerview
    }
    
    //グラデーション設定
    static func gradientLayer(frame:CGRect) -> CALayer{
        let gradientLayer = CAGradientLayer()
        let startColor = UIColor(red: 215/255, green: 66/255, blue: 96/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 225/255, green: 178/255, blue: 59/255, alpha: 1).cgColor
        let endColor = UIColor(red: 68/255, green: 157/255, blue: 155/255, alpha: 1).cgColor
        gradientLayer.colors = [startColor,secondColor,endColor]
        gradientLayer.frame = frame
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }
    
    //完了ボタンの作成
    static func setToolbar_Done(view:UIView, action: Selector?) -> UIToolbar{
        let toolbar_Done = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: view, action: nil)
        let doneItem_Date = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: action)
        toolbar_Done.setItems([spacelItem, doneItem_Date], animated: true)
        return toolbar_Done
    }
    //Date用完了ボタンの作成
    static func setToolbar_Done_ForDate(view:UIView, doneAction: Selector?,cancelAction: Selector?) -> UIToolbar{
        let toolbar_Done = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let CancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: view, action: cancelAction)
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: view, action: nil)
        let doneItem_Date = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: doneAction)
        toolbar_Done.setItems([CancelItem, spacelItem, doneItem_Date], animated: true)
        return toolbar_Done
    }
    
    
    //日付の設定
    static func DateFormmat(date:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.timeZone = NSTimeZone.local
        return formatter.string(from: date)
    }
    
    ///現在表示されているViewControllerを取得
    static func getTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return ViewProperties.getTopViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return ViewProperties.getTopViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return ViewProperties.getTopViewController(controller: presented)
        }
        return controller
    }
    
}
