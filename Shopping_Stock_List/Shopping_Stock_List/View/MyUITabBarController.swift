//
//  MyUITabBarController.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/16.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class MyUITabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabBar.barTintColor = ViewProperties.backgroundColor
    }
    
    func tabBarHeight() -> CGFloat{
        return self.tabBar.frame.size.height
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