//
//  CommentViewController.swift
//  Instagram
//
//  Created by WEBSYSTEM-MAC39 on 2023/09/06.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var postData: PostData!
    
    @IBOutlet weak var comment: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapSendButton(_ sender: Any) {
        if let postData = self.postData,
        let userName = Auth.auth().currentUser?.displayName {
            let saveComment = comment.text ?? ""
            let commentData = [userName : saveComment]
            
            var updateValue: FieldValue
            updateValue = FieldValue.arrayUnion([commentData])
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["comments": updateValue])
            
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
