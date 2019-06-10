import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

