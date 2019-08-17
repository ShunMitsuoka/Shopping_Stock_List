//
//  TestVIew.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class TestVIew: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var NameTF: UITextField!
    
    @IBOutlet weak var CategoryTF: UITextField!
    
    @IBOutlet weak var NumberTF: UITextField!
    
    
    @IBAction func complete(_ sender: Any) {
        let appendData:ShoppingDataClass = ShoppingDataClass(Name: NameTF.text!, Category: "", Number: 1, Image: "", Memo: "")
        print(appendData.Name)
        ListArrayClass.appendData(appendData: appendData)
        
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
