import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    // 画像が正方形に変更されたかどうか
    var isSquare = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初期設定
        self.imageView.frame.size = CGSize(width: self.view.bounds.width, height: 600)
        self.imageView.center = self.view.center
    }
    
    @IBAction func launchCamera(_ sender: UIBarButtonItem) {
        // 画像の入手方法 -> カメラ
        let camera = UIImagePickerController.SourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(camera) {
            let picker = UIImagePickerController()
            picker.sourceType = camera
            picker.delegate = self
            // モーダルビューを表示
            self.present(picker, animated: true)
        }
    }
    
    // 撮影を完了したタイミングで呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // オリジナルの画像を取得
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image
        // アルバムに保存
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        // モーダルビューを消去
        self.dismiss(animated: true)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        print("##tapView")
        
        // アニメーション
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
            
            if self.isSquare {
                // 正方形から拡大する
                self.imageView.frame.size = CGSize(width: self.view.bounds.width, height: 600)
                self.imageView.layer.cornerRadius = 0.0
                self.imageView.center = self.view.center
                self.isSquare = false
            } else {
                // 正方形に縮小する
                self.imageView.frame.size = CGSize(width: 250, height: 250)
                self.imageView.layer.cornerRadius = 20.0
                // 位置
                self.imageView.center = self.view.center
                self.isSquare = true
            }
        }, completion: nil)
    }
    
}

