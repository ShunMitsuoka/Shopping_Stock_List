//
//  AmountCell.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/08/19.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class AmountCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        //Cellサイズ設定
        self.frame = CGRect(x: 0, y: 0, width: ViewProperties.mainBoundSize.width, height: ViewProperties.cellHeight)
        self.backgroundColor = UIColor(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        let gradientLayer = ViewProperties.gradientLayer(frame: self.frame)
        self.layer.addSublayer(gradientLayer)
        
        self.selectionStyle = .none
        
        //Slider設定
        amountSlider.frame = CGRect(x: ViewProperties.mainBoundSize.width*0.10, y: ViewProperties.cellHeight/3, width: ViewProperties.mainBoundSize.width*0.80, height: 30)
        amountSlider.maximumTrackTintColor = UIColor.clear
        amountSlider.minimumTrackTintColor = UIColor.clear
        amountSlider.thumbTintColor = UIColor.white
        amountSlider.maximumValue = 100
        amountSlider.minimumValue = 0
        amountSlider.value = 100
        //amountSlider.state
        amountSlider.addTarget(self, action: #selector(self.SliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        self.addSubview(amountSlider)
        
        //amountValue初期化
//        amountValue = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let amountSlider = UISlider()
    var amountValue:Double?
    var coverView:UIView?
    let AmountSwitch = UISwitch()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func SliderValueChanged(_ sender : UISlider){
        amountSlider.isEnabled = false
        coverView?.removeFromSuperview()
        let value:CGFloat = CGFloat(amountSlider.value)
        let mainWidth = ViewProperties.mainBoundSize.width
        amountValue = Double(value)
        let viewWidth:CGFloat = mainWidth * (100 - value)/100
        let viewX:CGFloat = mainWidth - viewWidth
        coverView = UIView(frame: CGRect(x: viewX, y: 0, width: viewWidth, height: self.frame.height))
        coverView!.backgroundColor = UIColor(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        self.addSubview(coverView!)
        self.insertSubview(coverView!, belowSubview: amountSlider)
        amountSlider.isEnabled = true
    }
    
    //Detail画面の際に最初からグラデーションを削る
    func setColorBar(value:CGFloat){
        //Detail画面の際に最初からグラデーションを削る
        coverView?.removeFromSuperview()
        let value:CGFloat = value
        let mainWidth = ViewProperties.mainBoundSize.width
        amountValue = Double(value)
        let viewWidth:CGFloat = mainWidth * (100 - value)/100
        let viewX:CGFloat = mainWidth - viewWidth
        coverView = UIView(frame: CGRect(x: viewX, y: 0, width: viewWidth, height: self.frame.height))
        coverView!.backgroundColor = UIColor(red: 225/255, green: 200/255, blue: 168/255, alpha: 1)
        self.addSubview(coverView!)
        self.insertSubview(coverView!, belowSubview: amountSlider)
    }

}
