//
//  PostViewController.swift
//  Instagram
//
//  Created by WEBSYSTEM-MAC39 on 2023/08/28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD

class PostViewController: UIViewController {
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        // jpegに変換
        let imageData = image.jpegData(compressionQuality: 0.75)
        
        // 保存場所
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
        
        SVProgressHUD.show()
        
        // アップロード処理
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(imageData!, metadata: metadata) { (metadata, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                // 投稿処理をキャンセルし、先頭画面に戻る
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                return
            }
            
            // FireStoreに投稿データを保存する
            let name = Auth.auth().currentUser?.displayName
            let postDic = [
                "name": name!,
                "caption": self.textField.text!,
                "date": FieldValue.serverTimestamp(),
            ] as [String: Any]
            postRef.setData(postDic)
            
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }

    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
    }
}
