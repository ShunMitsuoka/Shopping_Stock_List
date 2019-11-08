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
    
    @IBOutlet weak var SaveBtn: UIButton!
    @IBAction func SaveBtn(_ sender: Any) {
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
        self.SaveBtn.frame = CGRect(x: ViewProperties.mainBoundSize.width/2 + 60, y: textBtnY, width: 80, height: 30)
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
        default:
            print("存在しないsegueIdentfierです。")
            fatalError()
        }
    }
    
    ///画像をトリミング
    func trimmingImage(capturedImage:UIImage) -> UIImage{
        
        let imageView:UIImageView = UIImageView(frame: CameraPreviewView.frame)
        imageView.contentMode = .center
        let imageView_:UIImageView = UIImageView(frame: CameraPreviewView.frame)
        imageView_.contentMode = .center
        
        let resizedSize = CGSize(width: CameraPreviewView.frame.width, height: CameraPreviewView.frame.height)
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0) // 変更
        capturedImage.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        print(resizedImage?.size)
        
        imageView_.image = resizedImage!
        self.CameraPreviewView.addSubview(imageView_)
        
        self.CameraPreviewView.addSubview(frameView!)

        
        let xRatio:CGFloat = capturedImage.size.width/self.CameraPreviewView.frame.width
        let yRatio:CGFloat = capturedImage.size.height/self.CameraPreviewView.frame.height
        let triWidth:CGFloat  = frameView!.frame.width * xRatio
        let triHeight:CGFloat  = frameView!.frame.height * yRatio
        
        let triX:CGFloat  = (capturedImage.size.width - triWidth)/2
        let triY:CGFloat  = (capturedImage.size.height - triHeight)/2
        let trimmingArea:CGRect = frameView!.frame
        print(triHeight)
        print(triWidth)
        print(CameraPreviewView.frame)
        print(frameView?.frame)
        print(capturedImage.size)
        print(trimmingArea)
        let imgRef = resizedImage!.cgImage?.cropping(to: trimmingArea)
        print(imgRef?.width)
        let trimImage = UIImage(cgImage: imgRef!, scale: 0, orientation: resizedImage!.imageOrientation)
        print(trimImage.size)
        imageView.image = trimImage
        self.CameraPreviewView.addSubview(imageView)
        
        return trimImage
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
            }
        }
    }
}
