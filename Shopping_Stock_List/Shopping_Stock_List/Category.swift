//
//  Category.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/04.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation

class CategoryClass {
    let CategoryArray_fundamental:Array<String> = ["aaa"]
    static var CategoryArray:Array<String>{
        get {
            let categoryArray = SaveDataClass.LoadData(KeyName: "CategoryData")
            return categoryArray as! Array<String>
        }
    }
}
