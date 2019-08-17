//
//  SaveData.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation

class SaveDataClass{
    
    enum UserDafaultsKey: String{
        case ShoppingData = "ShoppingData"
        case StockData = "StockData"
        case DeletedData = "DeletedData"
        case CategoryData = "CategoryData"
    }
    
    static func returnKey(Key:String) -> String{
        switch Key {
        case UserDafaultsKey.ShoppingData.rawValue:
            return UserDafaultsKey.ShoppingData.rawValue
        case UserDafaultsKey.StockData.rawValue:
            return UserDafaultsKey.StockData.rawValue
        case UserDafaultsKey.DeletedData.rawValue:
            return UserDafaultsKey.DeletedData.rawValue
        case UserDafaultsKey.CategoryData.rawValue:
            return UserDafaultsKey.CategoryData.rawValue
        default:
            print("存在しないKeyに入力されました。")
            fatalError()
        }
    }
    
    static func SaveData(inputData:Array<Any>, KeyName:String){
        switch KeyName {
        case UserDafaultsKey.ShoppingData.rawValue:
            let data = inputData as! Array<ShoppingDataClass>
            let encodeData = try? JSONEncoder().encode(data)
            UserDefaults.standard.set(encodeData, forKey: UserDafaultsKey.ShoppingData.rawValue)
        case UserDafaultsKey.StockData.rawValue:
            let data = inputData as! Array<StockDataClass>
            let encodeData = try? JSONEncoder().encode(data)
            UserDefaults.standard.set(encodeData, forKey: UserDafaultsKey.StockData.rawValue)
        case UserDafaultsKey.DeletedData.rawValue:
            let data = inputData as! Array<DeletedDataClass>
            let encodeData = try? JSONEncoder().encode(data)
            UserDefaults.standard.set(encodeData, forKey: UserDafaultsKey.DeletedData.rawValue)
        case UserDafaultsKey.CategoryData.rawValue:
            let data = inputData as! Array<String>
            let encodeData = try? JSONEncoder().encode(data)
            UserDefaults.standard.set(encodeData, forKey: UserDafaultsKey.CategoryData.rawValue)
        default:
            print("\(KeyName)は存在しないため保存できません。")
            fatalError()
        }
        
        UserDefaults.standard.synchronize()
        print("saveが完了しました。")
    }
    
    static func LoadData(KeyName:String) -> Array<Any>{
        print("\(KeyName)のデータをロードします。")
        switch KeyName {
        case UserDafaultsKey.ShoppingData.rawValue:
            if let LoadData = UserDefaults.standard.data(forKey: KeyName){
                let decodeData = try? JSONDecoder().decode(Array<ShoppingDataClass>.self, from: LoadData)
                return decodeData!
            }
        case UserDafaultsKey.StockData.rawValue:
            if let LoadData = UserDefaults.standard.data(forKey: KeyName){
                let decodeData = try? JSONDecoder().decode(Array<StockDataClass>.self, from: LoadData)
                return decodeData!
            }
        case UserDafaultsKey.DeletedData.rawValue:
            if let LoadData = UserDefaults.standard.data(forKey: KeyName){
                let decodeData = try? JSONDecoder().decode(Array<DeletedDataClass>.self, from: LoadData)
                return decodeData!
            }
        case UserDafaultsKey.CategoryData.rawValue:
            
            let category = CategoryClass()
            let encodeData = try? JSONEncoder().encode(category.CategoryArray_fundamental)
            UserDefaults.standard.register(defaults: [UserDafaultsKey.CategoryData.rawValue: encodeData!])
            if let LoadData = UserDefaults.standard.data(forKey: KeyName){
                let decodeData = try? JSONDecoder().decode(Array<String>.self, from: LoadData)
                return decodeData!
            }
        default:
            print("\(KeyName)というKeyNameが存在しません")
            fatalError()
        }
        print("\(KeyName)のデータが存在しません。")
        return []
    }
    
}
