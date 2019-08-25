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
        
        //notificationの監視
        self.configureObserer()
    }
    
    var mainBoundSize = ViewProperties.mainBoundSize
    var cellHeight = ViewProperties.cellHeight
    
    
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
