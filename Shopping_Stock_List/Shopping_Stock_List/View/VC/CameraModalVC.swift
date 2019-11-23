//
//  modal.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/11/12.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class CameraModalVC: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.setLayout()
    }
    
    ///表示する画像
    var shownImage:UIImage?
    @IBOutlet var baseView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!
    
    @IBAction func SaveBtnAction(_ sender: Any) {
        guard let preView = self.presentingViewController as? CameraVC else { return }
        dismiss(animated: false, completion: nil)
        if let image = self.shownImage{
            preView.SaveImageToPreView(savedImage: image)
        }
    }
    
    
    
    @IBAction func RetakeBtnAction(_ sender: Any) {
    }
    //カメラ画面に遷移する際の動作
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind_save"{
        }else if segue.identifier == "unwind_save"{
            }
    }
    
    func setImage(){
        if let image = self.shownImage{
            self.imageView.image = image
        }
    }
    
    ///レイアウト設定
    func setLayout(){
        if let image = shownImage{
            ///
            ///baseView設定
            ///
            let baseViewWidth:CGFloat = ViewProperties.mainBoundSize.width*0.9
            ///高さは画像の比に合わせる。
            let Ratio = baseViewWidth/image.size.width
            let baseViewHeight = image.size.height * Ratio
            let baseViewX = (ViewProperties.mainBoundSize.width - baseViewWidth)/2
            let baseViewY = (ViewProperties.mainBoundSize.height - baseViewHeight)/2
            baseView.frame = CGRect(x: baseViewX, y: baseViewY, width: baseViewWidth, height: baseViewHeight)
            baseView.backgroundColor = ViewProperties.backgroundColor
            baseView.layer.cornerRadius = 5
            baseView.clipsToBounds = true
            ///
            ///ImageView設定
            ///
            let imageViewWidth = baseViewWidth*0.6
            let imageViewHeight = baseViewHeight*0.6
            let imageViewX = (baseViewWidth - imageViewWidth)/2
            let imageViewY = (baseViewHeight - imageViewHeight)/2 - baseViewHeight*0.05
            imageView.frame = CGRect(x: imageViewX, y: imageViewY, width: imageViewWidth, height: imageViewHeight)
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
            
            ///
            ///Btn設定
            ///
            let BtnSize = ((baseViewWidth/2)*0.6, baseViewHeight*0.1)
            let BtnY = baseViewHeight*0.85
            let saveBtnX = baseViewWidth*0.6
            let retakeBtnX = baseViewWidth*0.1
            saveBtn.frame = CGRect(x: saveBtnX, y: BtnY, width: BtnSize.0, height: BtnSize.1)
            cancelBtn.frame = CGRect(x: retakeBtnX, y: BtnY, width: BtnSize.0, height: BtnSize.1)
            saveBtn.backgroundColor = UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
            cancelBtn.backgroundColor = UIColor(red: 189/255, green: 140/255, blue: 102/255, alpha: 1)
            saveBtn.tintColor = UIColor.black
            cancelBtn.tintColor = UIColor.black
        }
    }
    
}
