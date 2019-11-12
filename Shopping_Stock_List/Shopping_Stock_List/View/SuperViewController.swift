//
//  SuperViewController.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/24.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = ViewProperties.backgroundColor
        naviBarImageSize = CGSize(width: self.navigationHeight*0.6, height: self.navigationHeight*0.6)
        tabBarImageSize = CGSize(width: self.tabBarHeight*0.9, height: self.tabBarHeight*0.9)
        //notificationの監視
        self.configureObserer()
    }
    
    var mainBoundSize = ViewProperties.mainBoundSize
    var cellHeight = ViewProperties.cellHeight
    var navigationHeight:CGFloat!{
        get{
            return self.navigationController?.navigationBar.frame.size.height
        }
    }
    var tabBarHeight:CGFloat!{
        get{
            return self.tabBarController?.tabBar.frame.size.height
        }
    }
    var naviBarImageSize:CGSize!
    var tabBarImageSize:CGSize!
    
    //Notificationを設定
    func configureObserer(){
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyBoardWiiHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //keyboard出てきた時
    @objc func keyBoardWillShow(notification:Notification?){
        
    }
    
    //keyboard消えた時
    @objc func keyBoardWiiHide(notification:Notification?){

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
