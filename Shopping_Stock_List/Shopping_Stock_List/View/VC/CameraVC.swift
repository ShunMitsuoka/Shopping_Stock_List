//
//  CameraVC.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/10/20.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit
import AVFoundation

class CameraVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ViewProperties.backgroundColor
        setViewStyle()
        styleButton()
        // Do any additional setup after loading the view.
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
        setCaptureFrame()
    }
    
    ///デバイスからの入力と出力を管理するオブジェクトの作成
    var captureSession = AVCaptureSession()
    // カメラデバイスそのものを管理するオブジェクトの作成
    // メインカメラの管理オブジェクトの作成
    var mainCamera: AVCaptureDevice?
    // インカメの管理オブジェクトの作成
    var innerCamera: AVCaptureDevice?
    // 現在使用しているカメラデバイスの管理オブジェクトの作成
    var currentDevice: AVCaptureDevice?
    // キャプチャーの出力データを受け付けるオブジェクト
    var photoOutput : AVCapturePhotoOutput?
    // プレビュー表示用のレイヤ
    var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
    //imageを一時的に保存
    var capturedImage:UIImage?
    ///imageViewCellの大きさを保存
    var imageViewCell_frame:CGRect?
    var frameView:UIView?
    
    
    @IBOutlet weak var CameraPreviewView: UIView!
    @IBOutlet weak var BottomBarView: UIView!
    
    
    @IBOutlet weak var captureBtn: UIButton!
    @IBAction func captureBtn(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        // フラッシュの設定
        settings.flashMode = .auto
        // カメラの手ぶれ補正
        settings.isAutoStillImageStabilizationEnabled = true
        // 撮影された画像をdelegateメソッドで処理
        self.photoOutput?.capturePhoto(with: settings, delegate: self as AVCapturePhotoCaptureDelegate)
    }
    

    @IBOutlet weak var cancelBtn: UIButton!
    @IBAction func cancelBtn(_ sender: Any) {
    }
    
    
    // カメラの画質の設定
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    // デバイスの設定
    func setupDevice() {
        // カメラデバイスのプロパティ設定
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        // プロパティの条件を満たしたカメラデバイスの取得
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                mainCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                innerCamera = device
            }
        }
        // 起動時のカメラを設定
        currentDevice = mainCamera
    }
    
    // 入出力データの設定
    func setupInputOutput() {
        do {
            // 指定したデバイスを使用するために入力を初期化
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            // 指定した入力をセッションに追加
            captureSession.addInput(captureDeviceInput)
            // 出力データを受け取るオブジェクトの作成
            photoOutput = AVCapturePhotoOutput()
            // 出力ファイルのフォーマットを指定
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    // カメラのプレビューを表示するレイヤの設定
    func setupPreviewLayer() {
        // 指定したAVCaptureSessionでプレビューレイヤを初期化
        self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
        self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resize
        // プレビューレイヤの表示の向きを設定
        self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.cameraPreviewLayer?.frame = CameraPreviewView.frame
        self.CameraPreviewView.layer.insertSublayer(self.cameraPreviewLayer!, at: 0)
    }
    
    ///View設定
    func setViewStyle() {
        BottomBarView.backgroundColor = ViewProperties.backgroundColor
        let barHeight:CGFloat = ViewProperties.mainBoundSize.height*0.15
        let barWidth:CGFloat = ViewProperties.mainBoundSize.width
        let barX:CGFloat = 0
        let barY:CGFloat = ViewProperties.mainBoundSize.height - barHeight
        BottomBarView.frame = CGRect(x: barX, y: barY, width: barWidth, height: barHeight)
        
        let previewHeight:CGFloat = ViewProperties.mainBoundSize.height - barHeight
        let previewWidth:CGFloat = ViewProperties.mainBoundSize.width
        CameraPreviewView.frame = CGRect(x: 0, y: 0, width: previewWidth, height: previewHeight)
        CameraPreviewView.backgroundColor = ViewProperties.backgroundColor
    }
    
    func setCaptureFrame(){
        self.frameView = UIView()
        ///幅が大きい方に
        if let Cellframe = self.imageViewCell_frame{
            let ratio = CameraPreviewView.frame.width*0.7/Cellframe.width
            let frameWidth:CGFloat = Cellframe.width*ratio
            let frameHeight:CGFloat = Cellframe.height*ratio
            let frameX:CGFloat = (CameraPreviewView.frame.width - frameWidth)/2
            let frameY:CGFloat = (CameraPreviewView.frame.height - frameHeight)/2
            frameView!.frame = CGRect(x: frameX, y: frameY, width: frameWidth, height: frameHeight)
        }
        frameView!.layer.borderColor = UIColor.white.cgColor
        frameView!.layer.borderWidth = 3
        CameraPreviewView.addSubview(frameView!)
    }
    
    // ボタンのスタイルを設定
    func styleButton() {
        let captureBtnSize:CGFloat = 60
        let captureBtnY:CGFloat = (BottomBarView.frame.height - captureBtnSize)/2
        let textBtnY:CGFloat = (BottomBarView.frame.height - 30)/2
        self.captureBtn.frame = CGRect(x: (BottomBarView.frame.width - captureBtnSize)/2, y: captureBtnY, width: captureBtnSize, height: captureBtnSize)
        self.captureBtn.layer.borderColor = UIColor.white.cgColor
        self.captureBtn.layer.borderWidth = 5
        self.captureBtn.layer.cornerRadius = min(self.captureBtn.frame.width, self.captureBtn.frame.height) / 2
        
        self.cancelBtn.frame = CGRect(x: ViewProperties.mainBoundSize.width/2 - 140, y: textBtnY, width: 80, height: 30)
    }
    
    ///画像をトリミング
    func trimmingImage(capturedImage:UIImage) -> UIImage{
        let Imageframe = frameView!
        print("Viewのフレームは\(CameraPreviewView.frame)")
        print("imageViewのフレームは\(Imageframe.frame)")
        print("撮影した写真のsizeは\(capturedImage.size)")
        let xRatio:CGFloat = capturedImage.size.width/self.CameraPreviewView.frame.width
        let yRatio:CGFloat = capturedImage.size.height/self.CameraPreviewView.frame.height
        print("xとyの比は\(xRatio),\(yRatio)")
        let triX:CGFloat  = Imageframe.frame.origin.x * xRatio
        let triY:CGFloat  = Imageframe.frame.origin.y * yRatio
        print("トリミングするxとyは\(triX),\(triY)")
        let triWidth:CGFloat  = Imageframe.frame.width * xRatio
        let triHeight:CGFloat  = Imageframe.frame.height * yRatio
        print("トリミングする際のwidthとheightは\(triWidth),\(triHeight)")
        
        let imageView:UIImageView = UIImageView(frame: CameraPreviewView.frame)
        imageView.contentMode = .scaleAspectFit
        imageView.image = capturedImage.reSizeImage(reSize: CGSize(width: CameraPreviewView.frame.width, height: CameraPreviewView.frame.height))
        self.CameraPreviewView.addSubview(imageView)
        
        ///トリミングするためにcgImageに変換する際、サイズによってトリミングの向きを変える。
        var trimmingArea:CGRect!
        var imgRef:CGImage!
        var trimImage:UIImage!
        if triWidth > triHeight {
            print("回転させます")
            let cgimage = capturedImage.cgImage
            trimmingArea = CGRect(x: triY, y: triX, width: triHeight, height: triWidth)
            imgRef = cgimage!.cropping(to: trimmingArea)
            trimImage = UIImage(cgImage: imgRef!, scale: 0, orientation: capturedImage.imageOrientation)
        }else{
            trimmingArea = CGRect(x: triX, y: triY, width: triWidth, height: triHeight)
            imgRef = capturedImage.cgImage?.cropping(to: trimmingArea)
            trimImage = UIImage(cgImage: imgRef!, scale: 0, orientation: capturedImage.imageOrientation)
        }
        

        print("トリミング後の写真サイズは\(trimImage.size)")
        let resize_triImage = trimImage.reSizeImage(reSize: CGSize(width: Imageframe.frame.width, height: Imageframe.frame.height))
        let triImageView:UIImageView = UIImageView(frame: Imageframe.frame)
        triImageView.contentMode = .center
        triImageView.image = resize_triImage
        self.CameraPreviewView.addSubview(triImageView)
        
        return trimImage
    }
    
    //segue設定
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "unwind_fromCameraVC_save":
            if segue.destination is SuperVC_StockDetails{
                let SegueVC = segue.destination as! SuperVC_StockDetails
                if let capturedImage_ = self.capturedImage{
                    SegueVC.category_image_Cell?.imageview?.setImageOnSelf(image: capturedImage_)
                }
            }
        case "unwind_fromCameraVC_cancel":
            return
        //モーダル画面に遷移する際の動作
        case "fromCameraVCtoModal":
            let CameraModalVC = segue.destination as! CameraModalVC
            CameraModalVC.shownImage = self.capturedImage
        default:
            print("存在しないsegueIdentfierです。")
            fatalError()
        }
    }
    
    //モーダル画面からのunwind設定
    @IBAction func unwindPrev(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        switch unwindSegue.identifier {
        case "unwind_save":
            performSegue(withIdentifier: "unwind_fromCameraVC_save", sender: nil)
        case "unwind_cancel":
            for subview in self.CameraPreviewView.subviews{
                subview.removeFromSuperview()
            }
            setCaptureFrame()
        default:
            fatalError()
        }
    }

}

//MARK: AVCapturePhotoCaptureDelegateデリゲートメソッド
extension CameraVC: AVCapturePhotoCaptureDelegate{
    // 撮影した画像データが生成されたときに呼び出されるデリゲートメソッド
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            // Data型をUIImageオブジェクトに変換
            if let uiImage = UIImage(data: imageData){
                self.capturedImage = trimmingImage(capturedImage: uiImage)
                performSegue(withIdentifier: "fromCameraVCtoModal", sender: nil)
            }
        }
    }
}
