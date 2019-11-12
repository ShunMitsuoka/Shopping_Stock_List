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
        if let myTabBar = myTabBar{
            myTabBar.barTintColor = ViewProperties.backgroundColor
            myTabBar.tintColor = UIColor.black
            setTabBatItem()
        }
    }
    
    
    @IBOutlet weak var myTabBar: UITabBar?
    
    func tabBarHeight() -> CGFloat{
        return self.tabBar.frame.size.height
    }
    
    func setTabBatItem(){
        let imageSize = CGSize(width: self.tabBar.bounds.height*0.5, height: self.tabBar.bounds.height*0.5)
        
        let myTabBarItem1 = (myTabBar!.items?[0])! as UITabBarItem
        let image_item1 = UIImage(named: "shopping")?.reSizeImage(reSize: imageSize)
        myTabBarItem1.image = image_item1?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.title = "shoppingList".localized
//        myTabBarItem1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let myTabBarItem2 = (myTabBar!.items?[1])! as UITabBarItem
        let image_item2 = UIImage(named: "stock")?.reSizeImage(reSize: imageSize)
        myTabBarItem2.image = image_item2?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.title = "stockList".localized
        
        let myTabBarItem3 = (myTabBar!.items?[2])! as UITabBarItem
        let image_item3 = UIImage(named: "trash")?.reSizeImage(reSize: imageSize)
        myTabBarItem3.image = image_item3?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.title = "deletedList".localized
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
