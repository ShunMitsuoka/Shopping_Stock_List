//
//  SaveData.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation

class SaveData{
    
    enum UserDafaultsKey: String{
        case ShoppingData = "ShoppingData"
    }
    
    static func SaveData( data : Array<Any>){
        let Key : UserDafaultsKey = .ShoppingData
        UserDefaults.standard.set(data as! Array<ShoppingDataClass> , forKey: Key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    static func LoadData() -> Array<Any>{
        let Key : UserDafaultsKey = .ShoppingData
        let loadData = UserDefaults.standard.array(forKey: Key.rawValue)
        return loadData as! Array<Any>
    }
    
}
