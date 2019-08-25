//
//  Error_Alert.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/25.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation
import UIKit

class Error_Alert {
    
    
    static func ShowAlert(ViewController:UIViewController, title:String, message:String?) {
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let OKAction:UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction!) -> Void in
            print("OKボタンが押されました。")
            })
        alert.addAction(OKAction)
        ViewController.present(alert, animated: true, completion: nil)
    }
    
    static func ShowSeletableAlert(ViewController:UIViewController, title:String, _ message:String?) -> Bool{
        var bool:Bool!
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let OKAction:UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction!) -> Void in
            bool = true
        })
        let CancelAction:UIAlertAction = UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction!) -> Void in
            bool = false
        })
        
        alert.addAction(OKAction)
        alert.addAction(CancelAction)
        ViewController.present(alert, animated: true, completion: nil)
        return bool
    }
    
    
    
    
}
