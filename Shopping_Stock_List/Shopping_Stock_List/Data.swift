//
//  Data.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/06/04.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import Foundation
import UIKit

//削除データクラス
class DeletedClass : Codable {
    
    var Name:String!
    func Change_Name(name:String!){
        self.Name = name
    }
    
    var Category:String!
    func Change_Category(category:String!){
        self.Category = category
    }
    
    var Number:Double!
    func Cgange_Number(number:Double!){
        self.Number = number
    }
    
    var Image:String?
    func Change_Image(image:String!){
        self.Image = image
    }
    
    init(Name:String!,Category:String!,Number:Double!,Image:String?) {
        self.Name = Name
        self.Category = Category
        self.Number = Number
        self.Image = Image
    }
    
}

//買い物データクラス
class ShoppingDataClass : DeletedClass {
    
    var Memo:String?
    
    func Change_Memo(memo:String?){
        guard memo != nil else {
            self.Memo = ""
            return
        }
        self.Memo = memo
    }
    
    enum CodingKeys : String, CodingKey{
        case Name
        case Category
        case Number
        case Image
        case Memo
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.Memo = try values.decode(String.self, forKey: .Memo)
        let name = try values.decode(String.self, forKey: .Name)
        let category = try values.decode(String.self, forKey: .Category)
        let number = try values.decode(Double.self, forKey: .Number)
        let image = try values.decode(String.self, forKey: .Image)
        super.init(Name: name, Category: category, Number: number, Image: image)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.Name, forKey: .Name)
        try container.encode(self.Category, forKey: .Category)
        try container.encode(self.Number, forKey: .Number)
        try container.encode(self.Memo, forKey: .Memo)
        
    }
    
}

//ストックデータクラス
class StockDataClass : ShoppingDataClass{
    
    var Date:Date?
    func Change_Date(date:Date!){
        self.Date = date
    }
    
    var Amount:Double?
    func Change_Amount(amount:Double!){
        self.Amount = amount
    }
    
}

