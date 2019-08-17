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
class DeletedDataClass : Codable {
    
    var Name:String
    func Change_Name(name:String){
        self.Name = name
    }
    
    var Category:String
    func Change_Category(category:String){
        self.Category = category
    }
    
    var Number:Double
    func Cgange_Number(number:Double){
        self.Number = number
    }
    
    var Image:String
    func Change_Image(image:String){
        self.Image = image
    }
    
    init(Name:String,Category:String,Number:Double,Image:String?) {
        self.Name = Name
        self.Category = Category
        self.Number = Number
        if let image = Image{
            self.Image = image
        }else{
            self.Image = ""
        }
    }
    
}

//買い物データクラス
class ShoppingDataClass : DeletedDataClass {
    
    var Memo:String?
    
    func Change_Memo(memo:String?){
        guard memo != nil else {
            self.Memo = ""
            return
        }
        self.Memo = memo
    }
    
    enum ShoppingCodingKeys : String, CodingKey{
        case Name
        case Category
        case Number
        case Image
        case Memo
    }
    
    init(Name:String,Category:String,Number:Double,Image:String?,Memo:String?) {
        if let memo = Memo {
            self.Memo = memo
        } else {
            self.Memo = ""
        }
        super.init(Name: Name, Category: Category, Number: Number, Image: Image)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ShoppingCodingKeys.self)
        self.Memo = try values.decode(String.self, forKey: .Memo)
        let name = try values.decode(String.self, forKey: .Name)
        let category = try values.decode(String.self, forKey: .Category)
        let number = try values.decode(Double.self, forKey: .Number)
        let image = try values.decode(String.self, forKey: .Image)

        super.init(Name: name, Category: category, Number: number, Image: image)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ShoppingCodingKeys.self)
        try container.encode(self.Name, forKey: .Name)
        try container.encode(self.Category, forKey: .Category)
        try container.encode(self.Number, forKey: .Number)
        try container.encode(self.Memo, forKey: .Memo)
        try container.encode(self.Image, forKey: .Image)
    }
    
}

//ストックデータクラス
class StockDataClass : ShoppingDataClass{
    
    var ExpDate:Date?
    func Change_Date(date:Date!){
        self.ExpDate = date
    }
    
    var Amount:Double?
    func Change_Amount(amount:Double!){
        self.Amount = amount
    }
    
    enum StockCodingKeys : String, CodingKey{
        case Name
        case Category
        case Number
        case Image
        case Memo
        case ExpDate
        case Amount
    }
    
    init(Name:String,Category:String,Number:Double,Image:String?,Memo:String?,ExpDate:Date?,Amount:Double?) {
        self.ExpDate = ExpDate
        self.Amount = Amount
        super.init(Name: Name, Category: Category, Number: Number, Image: Image, Memo: Memo)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: StockCodingKeys.self)
        self.ExpDate = try values.decode(Date.self, forKey: .ExpDate)
        self.Amount = try values.decode(Double.self, forKey: .Amount)
        let name = try values.decode(String.self, forKey: .Name)
        let category = try values.decode(String.self, forKey: .Category)
        let number = try values.decode(Double.self, forKey: .Number)
        let image = try values.decode(String.self, forKey: .Image)
        let memo = try values.decode(String.self, forKey: .Memo)
        super.init(Name: name, Category: category, Number: number, Image: image, Memo: memo)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StockCodingKeys.self)
        try container.encode(self.Name, forKey: .Name)
        try container.encode(self.Category, forKey: .Category)
        try container.encode(self.Number, forKey: .Number)
        try container.encode(self.Memo, forKey: .Memo)
        try container.encode(self.Image, forKey: .Image)
        try container.encode(self.ExpDate, forKey: .ExpDate)
        try container.encode(self.Amount, forKey: .Amount)
    }
    
}

