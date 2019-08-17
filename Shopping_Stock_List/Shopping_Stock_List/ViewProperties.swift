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
    static let tableViewbackgroundColor = UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
    
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
    
    //内容表示
    static func stockCellView(name:String, date:String) -> UIView{
        let cellView = UIView(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width, height: cellHeight))
        cellView.backgroundColor = UIColor.clear
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: mainBoundSize.width*0.6, height: cellHeight))
        nameLabel.text = name
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.6/6)
        nameLabel.textAlignment = NSTextAlignment.center
        let dateLabel = UILabel(frame: CGRect(x: mainBoundSize.width*0.6, y:0 , width: mainBoundSize.width*0.4, height: cellHeight))
//        dateLabel.backgroundColor = UIColor.red
        dateLabel.text = date
        dateLabel.textColor = UIColor.black
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.font = UIFont.systemFont(ofSize: mainBoundSize.width*0.4/6 )
        cellView.addSubview(nameLabel)
        cellView.addSubview(dateLabel)
        //残量バー
        cellView.layer.addSublayer(gradientLayer())
        return cellView
    }
    
    //header情報
    static func headerView(section:Int) -> UIView{
        
        let headerview = UIView()
        headerview.frame.size = CGSize(width: ViewProperties.mainBoundSize.width, height: 30 )
        headerview.backgroundColor = UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
        let BottomLine = CALayer()
        BottomLine.frame = CGRect(x: 0, y: 28, width: ViewProperties.mainBoundSize.width,height: 2)
        BottomLine.backgroundColor = UIColor(red: 120/255, green: 91/255, blue: 84/255, alpha: 1).cgColor
        headerview.layer.addSublayer(BottomLine)
        let headerLabel = UILabel(frame: CGRect(x:10, y: -1, width: mainBoundSize.width, height: 30))
        headerLabel.text = CategoryClass.CategoryArray[section]
        headerLabel.font = UIFont.systemFont(ofSize: 25)
        headerview.addSubview(headerLabel)
        return headerview
    }
    
    //グラデーション設定
    static func gradientLayer() -> CALayer{
        let gradientLayer = CAGradientLayer()
        let startColor = UIColor(red: 215/255, green: 66/255, blue: 96/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 225/255, green: 178/255, blue: 59/255, alpha: 1).cgColor
        let endColor = UIColor(red: 68/255, green: 157/255, blue: 155/255, alpha: 1).cgColor
        gradientLayer.colors = [startColor,secondColor,endColor]
        gradientLayer.frame = CGRect(x: 0, y:ViewProperties.cellHeight*0.93 , width: ViewProperties.mainBoundSize.width, height: ViewProperties.cellHeight*0.07)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }
    
    
}
