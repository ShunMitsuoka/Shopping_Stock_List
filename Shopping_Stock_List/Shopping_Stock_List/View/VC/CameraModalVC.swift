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
        
        self.setImage()
    }
    
    ///表示する画像
    var shownImage:UIImage?
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    //カメラ画面に遷移する際の動作
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwind_save"{
            let CameraVC = segue.destination as! CameraVC
        }else if segue.identifier == "unwind_save"{
                let CameraVC = segue.destination as! CameraVC
            }
    }
    
    func setImage(){
        if let image = self.shownImage{
            self.imageView.image = image
        }
    }
    
}
