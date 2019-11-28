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
    
    enum DeletedCodingKeys : String, CodingKey{
        case Name
        case Category
        case Number
        case Image
    }
    
    var Name:String
    func Change_Name(name:String){
        self.Name = name
    }
    
    var Category:String
    func Change_Category(category:String){
        self.Category = category
    }
    
    var Number:Double?
    func Cgange_Number(number:Double){
        self.Number = number
    }
    
    var Image:UIImage?
    func Change_Image(image:UIImage){
        self.Image = image
    }
    
    init(Name:String,Category:String?,Number:Double?,Image:UIImage?) {
        //nilだった場合の処理
        //Number = nil
        //Image = nil
        self.Name = Name
        self.Category = Category ?? CategoryClass.CategoryArray.last!
        self.Number = Number
        self.Image = Image
    }
    
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DeletedCodingKeys.self)
        let name = try values.decode(String.self, forKey: .Name)
        let category = try values.decode(String.self, forKey: .Category)
        let number = try values.decode(Double?.self, forKey: .Number)
        let image: UIImage?
        if let imageDataBase64String = try values.decode(String?.self, forKey: .Image){
            if let data = Data(base64Encoded: imageDataBase64String) {
                image = UIImage(data: data)
            } else {
                image = nil
            }
        } else {
            image = nil
        }
        self.init(Name: name, Category: category, Number: number, Image: image)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DeletedCodingKeys.self)
        try container.encode(Name, forKey: .Name)
        try container.encode(Category, forKey: .Category)
        try container.encode(Number, forKey: .Number)
        ///imageDataBase64Stringは変換時に何かしらがnilだったらnil
        let imageDataBase64String = Image?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        try container.encode(imageDataBase64String, forKey: .Image)
    }
    
}

//買い物データクラス
class ShoppingDataClass : DeletedDataClass {
    
    var Memo:String?
    
    func Change_Memo(memo:String?){
        self.Memo = memo ?? ""
    }
    
    enum ShoppingCodingKeys : String, CodingKey{
        case Name
        case Category
        case Number
        case Image
        case Memo
    }
    
    init(Name:String,Category:String?,Number:Double?,Image:UIImage?,Memo:String?) {
        super.init(Name: Name, Category: Category, Number: Number, Image: Image)
        self.Memo = Memo
    }
    
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ShoppingCodingKeys.self)
        let name = try values.decode(String.self, forKey: .Name)
        let category = try values.decode(String.self, forKey: .Category)
        let number = try values.decode(Double?.self, forKey: .Number)
        let image: UIImage?
        if let imageDataBase64String = try values.decode(String?.self, forKey: .Image){
            if let data = Data(base64Encoded: imageDataBase64String) {
                image = UIImage(data: data)
            } else {
                image = nil
            }
        } else {
            image = nil
        }
        let memo = try values.decode(String?.self, forKey: .Memo)
        self.init(Name: name, Category: category, Number: number, Image: image, Memo:memo)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ShoppingCodingKeys.self)
        try container.encode(Name, forKey: .Name)
        try container.encode(Category, forKey: .Category)
        try container.encode(Number, forKey: .Number)
        ///imageDataBase64Stringは変換時に何かしらがnilだったらnil
        let imageDataBase64String = Image?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        try container.encode(imageDataBase64String, forKey: .Image)
        try container.encode(self.Memo, forKey: .Memo)
    }
    
}

//ストックデータクラス
class StockDataClass : ShoppingDataClass{
    
    var ExpDate:String?
    func Change_Date(date:String){
        self.ExpDate = date
    }
    
    var Amount:Double?
    func Change_Amount(amount:Double){
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
    
    init(Name:String,Category:String?,Number:Double?,Image:UIImage?,Memo:String?,ExpDate:String?,Amount:Double?) {
        super.init(Name: Name, Category: Category, Number: Number, Image: Image, Memo: Memo)
        //値の代入とnilだった場合の処理
        self.ExpDate = ExpDate
        self.Amount = Amount
        }
    
    required convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: StockCodingKeys.self)
        let name = try values.decode(String.self, forKey: .Name)
        let category = try values.decode(String.self, forKey: .Category)
        let number = try values.decode(Double?.self, forKey: .Number)
        let imageDataBase64String = try values.decode(String?.self, forKey: .Image)
        let image: UIImage?
        if let data = Data(base64Encoded: imageDataBase64String!) {
            image = UIImage(data: data)
        } else {
            image = nil
        }
        
        let memo = try values.decode(String?.self, forKey: .Memo)
        let expDate = try values.decode(String?.self, forKey: .ExpDate)
        let amount = try values.decode(Double?.self, forKey: .Amount)
        self.init(Name: name, Category: category, Number: number, Image: image, Memo:memo,ExpDate:expDate, Amount:amount)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StockCodingKeys.self)
        try container.encode(Name, forKey: .Name)
        try container.encode(Category, forKey: .Category)
        try container.encode(Number, forKey: .Number)
        ///imageDataBase64Stringは変換時に何かしらがnilだったらnil
        let imageDataBase64String = Image?.jpegData(compressionQuality: 0.1)?.base64EncodedString()
        try container.encode(imageDataBase64String, forKey: .Image)
        try container.encode(self.Memo, forKey: .Memo)
        try container.encode(self.ExpDate, forKey: .ExpDate)
        try container.encode(self.Amount, forKey: .Amount)
    }
    
}

