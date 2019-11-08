//
//  SaveData.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation
import UIKit

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
//        print("\(KeyName)のデータをロードします。")
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
    
    //データ追加
    static func add_StockData(Name:String,Category:String,Number:Double?,Image:UIImage?,Memo:String?,ExpDate:String?,Amount:Double?){
        let data:StockDataClass = StockDataClass(Name: Name, Category: Category, Number: Number, Image: Image, Memo: Memo, ExpDate: ExpDate, Amount: Amount)
        var ArrayData = LoadData(KeyName: UserDafaultsKey.StockData.rawValue) as! Array<StockDataClass>
        ArrayData.append(data)
        SaveData(inputData: ArrayData, KeyName: UserDafaultsKey.StockData.rawValue)
    }
    
    static func add_ShoppingData(Name:String,Category:String,Number:Double?,Image:UIImage?,Memo:String?){
        let data:ShoppingDataClass = ShoppingDataClass(Name: Name, Category: Category, Number: Number, Image: Image, Memo: Memo)
        var ArrayData = LoadData(KeyName: UserDafaultsKey.ShoppingData.rawValue) as! Array<ShoppingDataClass>
        ArrayData.append(data)
        SaveData(inputData: ArrayData, KeyName: UserDafaultsKey.ShoppingData.rawValue)
    }
    
    static func add_DeletedData(Name:String,Category:String,Number:Double?,Image:UIImage?){
        let data:DeletedDataClass = DeletedDataClass(Name: Name, Category: Category, Number: Number, Image: Image)
        var ArrayData = LoadData(KeyName: UserDafaultsKey.DeletedData.rawValue) as! Array<DeletedDataClass>
        ArrayData.append(data)
        SaveData(inputData: ArrayData, KeyName: UserDafaultsKey.DeletedData.rawValue)
    }
    
    static func add_Category(category:String){
        var categoryArray = CategoryClass.CategoryArray
        categoryArray.insert(category, at: categoryArray.count-1)
        SaveData(inputData: categoryArray, KeyName: UserDafaultsKey.CategoryData.rawValue)
        
    }
    
    
}
