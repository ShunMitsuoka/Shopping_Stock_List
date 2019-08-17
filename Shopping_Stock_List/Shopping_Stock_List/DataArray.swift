//
//  DataArray.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/06.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation

class ListArrayClass{
    
    ////////////////////////////////////////////////////
    static var ShoppingListArray:[ShoppingDataClass] {
        get { return SaveDataClass.LoadData(KeyName: SaveDataClass.returnKey(Key: "ShoppingData") ) as! [ShoppingDataClass] }
    }
    
    static func appendData(appendData:ShoppingDataClass){
        var Array = SaveDataClass.LoadData(KeyName: SaveDataClass.returnKey(Key: "ShoppingData") ) as! [ShoppingDataClass]
        Array.append(appendData)
        SaveDataClass.SaveData(inputData: Array, KeyName: "ShoppingData")
    }
    ////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////
    static var StockListArray:[StockDataClass] {
        get { return SaveDataClass.LoadData(KeyName: SaveDataClass.returnKey(Key: "StockData") ) as! [StockDataClass] }
    }
    static func appendData(appendData:StockDataClass){
        var Array = SaveDataClass.LoadData(KeyName: SaveDataClass.returnKey(Key: "StockData") ) as! [StockDataClass]
        Array.append(appendData)
        SaveDataClass.SaveData(inputData: Array, KeyName: "StockData")
    }
    ////////////////////////////////////////////////////
    
    
    ////////////////////////////////////////////////////
    static var DeletedListArray:[DeletedDataClass] {
        get { return SaveDataClass.LoadData(KeyName: SaveDataClass.returnKey(Key: "DeletedData") ) as! [DeletedDataClass] }
    }
    static func appendData(appendData:DeletedDataClass){
        var Array = SaveDataClass.LoadData(KeyName: SaveDataClass.returnKey(Key: "DeletedData") ) as! [DeletedDataClass]
        Array.append(appendData)
        SaveDataClass.SaveData(inputData: Array, KeyName: "DeletedData")
    }
    ////////////////////////////////////////////////////
}

